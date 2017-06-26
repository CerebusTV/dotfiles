# Use jq to create csv from json file
jq -r '.payment_history | .[] | [.payment_number, .receipt_amount, .interest_paid, .amount_due, .loan_id, .payment_status, .principal_only] | @csv' loan_payments.json > loan_payments.csv

# Use jq to create csv of Digital Assets from mongoexport
jq -r '. | [._id, .title, .display_on_website, .suppress_on_investor_site, .suppress_on_advisor_site, .expires_at."$date", .changed_at."$date", .published_at."$date", .searchable, .path, .sami_code] | @csv' assets.json

# !!! Use jq to create csv given fields but does not work on nested values
jq -s -r '["_id", "title", "display_on_website", "suppress_on_investor_site", "suppress_on_advisor_site", "expires_at.$date", "changed_at.$date", "published_at.$date", "searchable", "path", "sami_code"] as $fields| $fields, (.[] | [.[$fields[]]]) | @csv' assets.json 



# Digital Assets 
curl 'http://qa2-investor2:8080/digital_assets.json' >! digital_assets.json

# Missing distribution channel
cat digital_assets.json | jq '.[] | select(.distribution_channels | length == 0) | .title'

# Find documents marke as institutional
cat digital_assets.json | jq '.[] | select(select(.distribution_channels[] |  contains("institutional-website"))) | .title'

cat digital_assets.json | jq '.[] | select(select(.distribution_channels[] |  contains("institutional-website"))) | { "id": .digital_asset_id, "title":.title, "fund_codes":.fund_codes}'

cat digital_assets.json | jq '.[] | select(.fund_codes) | select(select(.fund_codes[] | contains("GLOS")))'
