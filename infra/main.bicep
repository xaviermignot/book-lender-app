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

@description('The custom domain to use for the website.')
param customDomain string

@description('The custom domain to use for the APIs.')
param apiCustomDomain string

@description('The contact information about the APIM publisher.')
param apimPublisher object

@description('Information about the DNS Zone to use (resource group and name).')
param dnsZone object

var suffix = '${env}-book-lender'
var uniqueSuffix = '${suffix}-${uniqueString(subscription().id, env, location)}'

var tags = {
  projectName: 'BookLender'
  env: env
  deploymentTool: 'Bicep'
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${suffix}'
  location: location
  tags: union(tags, { bicepModule: 'main' })
}

module resources 'resources.bicep' = {
  name: 'deploy-resources'
  scope: rg

  params: {
    location: location
    cdnLocation: cdnLocation
    suffix: suffix
    uniqueSuffix: uniqueSuffix
    enableCosmosDbFreeTier: enableCosmosDbFreeTier
    customDomain: customDomain
    apiCustomDomain: apiCustomDomain
    apimPublisher: apimPublisher
    dnsZone: dnsZone
    defaultTags: tags
  }
}
