param suffix string
param location string
param accountName string

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' existing = {
  name: accountName
}

resource cosmosDbConnection 'Microsoft.Web/connections@2016-06-01' = {
  name: 'documentdb'
  location: location

  properties: {
    displayName: 'ala-connection-cdb'
    parameterValues: {
      databaseAccount: accountName
      accessKey: cosmosDbAccount.listKeys().primaryMasterKey
    }
    api: {
      id: '${subscription().id}/providers/Microsoft.Web/locations/${location}/managedApis/documentDb'
    }
  }
}

resource logicAppsMsi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'msi-${suffix}'
  location: location
}

output connection object = {
  connectionId: cosmosDbConnection.id
  connectionName: cosmosDbConnection.name
}

output msi object = {
  id: logicAppsMsi.id
  principalId: logicAppsMsi.properties.principalId
}
