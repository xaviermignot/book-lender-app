targetScope = 'subscription'

@description('Specifies the Azure region to use.')
param location string

@description('Specifies the Azure region to use for CDN profiles and endpoints.')
param cdnLocation string

@description('Specifies the targetted environment.')
@allowed([ 'dev', 'prod' ])
param env string

@description('Indicates if CosmosDb free tier should be enabled.')
param enableCosmosDbFreeTier bool = false

var suffix = '${env}-book-lender-${uniqueString(subscription().id, location)}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${suffix}'
  location: location
}

module resources 'resources.bicep' = {
  name: 'deploy-resources'
  scope: rg

  params: {
    location: location
    cdnLocation: cdnLocation
    suffix: suffix
    enableCosmosDbFreeTier: enableCosmosDbFreeTier
  }
}
