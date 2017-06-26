function dataManagement() {
  // Change database
  use edist_development;

  // Drop database
  // db.dropDatabase();

  // Copy the development edist content database
  db.copyDatabase('edist_staging', 'edist_development', 'dev1-web-db1:33478');

  // Copy the development fund database that has assets_as_of_date data
  db.copyDatabase('fund', 'fund_development', 'dev1-web-db1:33478');

  // Convert data field from String to Date
  var cursor = db.enterprise_products.find({"characteristics.as_of_date": {$exists: true}}); 
  while (cursor.hasNext()) { 
      var doc = cursor.next(); 
      if ("string" == typeof doc.characteristics.as_of_date) {
        db.enterprise_products.update({_id : doc._id}, {$set : {"characteristics.as_of_date" : new ISODate(doc.characteristics.as_of_date) }});
      }
  }

}


function aggregation() {
  // Count distinct
  db.digital_assets_accent.aggregate({
    $group: {
      _id: {
        "content_type": "$content_type",
        "_id": "$_id"
      },
      number: {
        $sum: 1
      }
    }
  }, {
    $group: {
      _id: "$_id.content_type",
      number: {
        $sum: 1
      }
    }
  });

  // Count distinct greater than 1
  db.marketing_products.aggregate({
    $group: {
      _id: {
        "slug": "$slug",
        "_id": "$_id"
      },
      number: {
        $sum: 1
      }
    }
  }, {
    $group: {
      _id: "$_id.slug",
      number: {
        $sum: 1
      }
    }
  }, {
    $match: {
      number: {
        $gt: 1
      }
    }
  });

  // Distinct share classes with matching ids
  db.enterprise_products.aggregate([
     { $group : { _id : "$concrete_products.share_class", funds: { $push: "$_id" } } }
   ]);

  // Find distinct product types
  db.enterprise_products.distinct('type');

  db.enterprise_products.distinct('investment_classification', {
    type: "GIPS Composite"
  });

  db.enterprise_products.distinct('investment_classification');

  db.enterprise_products.distinct('investment_capability_level_1');

  db.enterprise_products.distinct('investment_capability_level_2');

  db.enterprise_products.aggregate({
    $group: {
      _id: {
        investment_classification: "$investment_classification",
        investment_capability_level_1: "$investment_capability_level_1",
        investment_capability_level_2: "$investment_capability_level_2"
      }
    }
  });

  db.enterprise_products.aggregate([{
    $match: {
      type: {
        $eq: "GIPS Composite"
      }
    }
  }, {
    $group: {
      _id: {
        investment_classification: "$investment_classification"
      }
    }
  }]);
}

function queries() {
  // Find all Investor site articles
  db.articles.find({
    "article_media_type": "image",
    "distribution_channels": {
      $in: ['investor-website']
    }
  });

  // Find all Investor site planning articles
  db.articles.find({
    "article_media_type": "image",
    "distribution_channels": {
      $in: ['investor-website']
    }
  });

  // Find retirement planning page
  db.contents.find({
    "slug": "investor-landing-page-retirement"
  });

  // Find the most recent deployment package skipping older records.
  db.deployment_packages.find().skip(295);

  // Find personalities with exactly two designations
  db.personalities.find({
    'designations': {
      $size: 2
    }
  });

  // Find personalities with at least two designations
  db.personalities.find({
    'designations.1': {
      $exists: true
    }
  });

  // Find articles with a quote
  db.articles.find({
    'quote': {
      $exists: true
    }
  });

  // Find young products
  db.enterprise_products.find({
    "inception_date": {
      $gt: ISODate("2016-03-04T00:00:00.000+0000")
    }
  });

  // Nested values
  enterprise_products.find({
    $or: [{
      "performance_chart.primary._id": "1003"
    }, {
      "performance_chart.secondary._id": "1003"
    }]
  });

  // Find interior landing where slug like regex
  db.interior_landing_pages.find({
    'slug': /qa.*/
  });

  // Find expired documents in edist database
  db.digital_assets_accent.find({
    "expires_at": {
      "$lte": new ISODate("2014-09-26T21:00:00.000Z")
    }
  });

  // Get distinct roles for personalities
  db.personalities.distinct('role');

  // Get the id and array size for products that have more than 1 category in tier 1 with display of tile
  db.portfolio_holdings.aggregate(
    [{
      $unwind: "$categories"
    }, {
      $match: {
        $and: [{
          "categories.tier": 1
        }, {
          "categories.display_style": "tile"
        }]
      }
    }, {
      $group: {
        _id: "$_id",
        categories: {
          $push: "$categories"
        }
      }
    }, {
      $project: {
        _id: 1,
        categories_size: {
          $size: "$categories"
        }
      }
    }, {
      $match: {
        "categories_size": {
          $gt: 1
        }
      }
    }]);



}

function updates() {
  // Update all products setting a value
  db.products.update({}, {
    $set: {
      page_sections: []
    }
  }, {
    multi: true
  });
}

function accent_queries() {
  db.digital_assets_accent.find({
    "product_ids": {
      $in: ['520']
    }
  });

  db.digital_assets_accent.find({
    $and: [{
      "fund_codes": {
        $in: ["02055"]
      }
    }, {
      "content_type": "74"
    }]
  })

  db.digital_assets_accent.find({
    $where: "this._id != this.digital_asset_id"
  })
}

function admin() {
  // List all database statistics for the server
  db._adminCommand("listDatabases").databases.forEach(function(d) {
    mdb = db.getSiblingDB(d.name);
    printjson(mdb.stats());
  })
}
