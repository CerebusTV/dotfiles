##############
# Git
##############

# Get project names concatenating results
for n ({1..24});do curl -s --header "Accept: application/json" "https://github.pinnacol.com/api/v3/orgs/pinnacol/repos?type=all&page=$n" | jq -r '.[] | .html_url' >>| ~/repos.txt; done

# Clone all the repos
for f in `cat ~/repos.txt`; do gfc $f; done

# Find all git repos 
function git_dirs {
  find . -type d -name '.git'| cut -d/ -f2 | sort | uniq
}


# Update repos
for p in `git_dirs`; do cd $p; git pull; cd -; done

###
# Files in subdirectories
###
find . -type f -print | cut -d/ -f2 | sort | uniq -c | sort -rn

for d in `find . -type d -print`; do filec=`ls -1 $d | wc -l`; echo "$filec $d"; done | sort -n


# Find all directories that have source code in dev
function src_dirs {
  for d in `find . -type d -maxdepth 1 | cut -d/ -f2`
  do
    if [[ ! -a $d/.ignoremetrics ]]
    then
      echo $d
    fi
  done
}




##############
# Lines of Code
##############

###
# CLOC
###
cloc --quiet `src_dirs` >! metrics/cloc.txt

###
# SLOCCount
###
sloccount `src_dirs` >! metrics/sloccount.txt

# Count files matching a pattern by subdirectory
function file_count {
  for p in `src_dirs`; do file_count=`find $p -name $1 -print | wc -l`; echo "$file_count $p"; done | sort -n
}



##############
# Ruby
##############

# Find all ruby projects 
function ruby_dirs {
  find . -name 'Gemfile'| cut -d/ -f2 | sort | uniq
}

###
# PMD
###

# Copied code report
pmd cpd --minimum-tokens 25 --language ruby --files `ruby_dirs` --format xml >! metrics/cpd_ruby.xml; xsltproc -o metrics/cpd_ruby.html ~/lib/pmd/cpdhtml.xslt metrics/cpd_ruby.xml
pmd cpd --minimum-tokens 50 --language ruby --files `ruby_dirs` >! metrics/cpd_ruby.txt


###
# metric_fu
###

# disabled because of errors: flog, reek
for proj in `ruby_dirs | grep -v oracle-dev-tools`; do cd ~/dev/$proj; echo "Computing metrics for: $proj"; gtimeout 60 metric_fu --no-flog --no-reek --no-open --out "~/dev/metric_fu/$proj"; done

for proj in `ruby_dirs`; do cd ~/dev/$proj; metric_fu --no-flog --no-reek --no-open --out "~/dev/metric_fu/$proj"; done


###
# rubycritic
###

# Ruby critic all ruby projects
for proj in `ruby_dirs`; do rubycritic -s 1 -p "metrics/ruby/$proj" --no-browser $proj; done

# Find projects with zero score for removal
find 'metrics/ruby' -d 2 -name overview.html -exec grep -q 'score = 0.0' \; -print| cut -d/ -f-3

# Remove project with no ruby critic score
rm -rf `find 'metrics/ruby' -d 2 -name overview.html -exec grep -q 'score = 0.0' {} \; -print | cut -d/ -f-3`

# Run critic across projects once zero score projects have been trimmed
rubycritic --no-browser -p metrics/rubycritic `ls metrics/ruby`


###
# flay
###
flay -m 32 --diff `ruby_dirs` >! metrics/flay_32.txt


###
# Saikuro - cyclomatic complexity
###
cd ~ && saikuro -c -t -i dev -y 0 -w 11 -e 16 -o saikuro_summary && mv saikuro_summary dev/metrics && cd dev


###
# Graph dependecies
###
for proj in `ruby_dirs`; do cd ~/dev/$proj; echo "Graphing dependencies for: $proj"; bundle viz; done




##############
# TypeScript
##############

###
# Copied code
#   reads config: .cpd.yaml
###
jscpd --config cpd.typescript.yaml; xsltproc -o metrics/cpd_typescript.html ~/lib/jscpd/simple.xsl cpd_typescript.xml




##############
# Database
##############

###
# PL/SQL Copied code
###
pmd cpd --minimum-tokens 50 --language plsql --files FUNCTIONS --format xml >! metrics/cpd.xml; xsltproc -o metrics/cpd_functions.html ~/lib/pmd/cpdhtml.xslt metrics/cpd.xml

pmd cpd --minimum-tokens 50 --language plsql --files PROCEDURES --format xml >! metrics/cpd.xml; xsltproc -o metrics/cpd_procedures.html ~/lib/pmd/cpdhtml.xslt metrics/cpd.xml

pmd cpd --minimum-tokens 50 --language plsql --files PACKAGE_BODIES --format xml >! metrics/cpd.xml; xsltproc -o metrics/cpd_package_bodies.html ~/lib/pmd/cpdhtml.xslt metrics/cpd.xml

###
# PL/SQL Code size
###
pmd pmd -d . -l plsql -R rulesets/plsql/codesize.xml -f html >! metrics/pmd_codesize.html

pmd pmd -d . -l plsql -R rulesets/plsql/TomKytesDespair.xml -f html >! metrics/pmd_tom_kytes_despair.html

###
# SchemaSpy
#
# Options:
#   -imageformat  graph image format: svg | png
#   -i            include tables by Java regular expression pattern
#   -I            exclude tables by Java regular expression pattern
#   -o            output directory
#   -db           database name
#   -cat          database catalog
#   -s            database schema
#   -u            database user
#   -t            database type: orathin | ora| pg
#   -host         database host
#   -port         database port
###
java -jar lib/schemaSpy.jar -imageFormat svg -t orathin -dp lib/ojdbc7.jar -db twcis -host devhost -port 1621 -s WCIS_DBA -u wcis_dba -p O1dGl0ry -o results/db/schemaSpy

java -jar lib/schemaspy-6.0.0-rc1.jar -imageformat svg -t orathin -dp lib/ojdbc7.jar -db twcis -cat twcis -host devhost -port 1621 -s WCIS_DBA -u wcis_dba -p O1dGl0ry -o results/db/schemaSpy


