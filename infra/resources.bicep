param suffix string
param location string
param enableCosmosDbFreeTier bool

module cosmosDb 'modules/cosmosDb.bicep' = {
  name: 'deploy-cosmos-db'

  params: {
    location: location
    suffix: suffix
    enableFreeTier: enableCosmosDbFreeTier
  }
}

module logicAppsBase 'modules/logicAppBase.bicep' = {
  name: 'deploy-ala-base'

  params: {
    accountName: cosmosDb.outputs.accountName
    location: location
    suffix: suffix
  }
}

var logicApps = {
  'get-books': loadJsonContent('logic_apps/getBooksArm.json')
  'get-book-by-isbn': loadJsonContent('logic_apps/getBookByIsbnArm.json')
  'post-book': loadJsonContent('logic_apps/postBookArm.json')
  'lend-book': loadJsonContent('logic_apps/lendBookArm.json')
}

module logicAppDeployments 'modules/logicApp.bicep' = [for logicApp in items(logicApps): {
  name: 'deploy-ala-${logicApp.key}'

  params: {
    name: logicApp.key
    location: location
    msi: logicAppsBase.outputs.msi
    logicAppArmTemplate: logicApp.value
    suffix: suffix
  }
}]
