param uniqueSuffix string
param location string
param enableFreeTier bool
@description('The default tags to assign to resources.')
param defaultTags object

var tags = union(defaultTags, { bicepModule: 'cosmosDb' })

resource account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: 'cdb-${uniqueSuffix}'
  location: location
  tags: tags

  properties: {
    databaseAccountOfferType: 'Standard'
    enableFreeTier: enableFreeTier

    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }

    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
  }
}

resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-05-15' = {
  name: 'db-${uniqueSuffix}'
  parent: account
  tags: tags

  properties: {
    resource: {
      id: 'db-${uniqueSuffix}'
    }
  }
}

resource deparmentsContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-05-15' = {
  name: 'books'
  parent: database
  tags: tags

  properties: {
    resource: {
      partitionKey: {
        paths: [ '/id' ]
      }
      id: 'books'
    }
  }
}

resource cheesesContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-05-15' = {
  name: 'users'
  parent: database
  tags: tags

  properties: {
    resource: {
      partitionKey: {
        paths: [ '/id' ]
      }
      id: 'users'
    }
  }
}

output accountName string = account.name
