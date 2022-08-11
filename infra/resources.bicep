@description('The suffix to use in resource naming.')
param suffix string
@description('The suffix to use in resource naming when the scope of uniqueness is global.')
param uniqueSuffix string
param location string
param cdnLocation string
param enableCosmosDbFreeTier bool
param customDomain string
param dnsResourceGroup string

module deploymentScriptsIdentity 'modules/deploymentScriptIdentity.bicep' = {
  name: 'deploy-scripts-identity'

  params: {
    location: location
    suffix: suffix
  }
}

module cosmosDb 'modules/cosmosDb.bicep' = {
  name: 'deploy-cosmos-db'

  params: {
    location: location
    uniqueSuffix: uniqueSuffix
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

module cdnStaticWebsite 'modules/cdn/staticWebsite.bicep' = {
  name: 'deploy-cdn-static-website'

  params: {
    location: location
    uniqueSuffix: uniqueSuffix
    deploymentScriptIdentity: deploymentScriptsIdentity.outputs.msi
  }
}

module cdnProfile 'modules/cdn/profile.bicep' = {
  name: 'deploy-cdn-profile'

  params: {
    location: cdnLocation
    staticWebsiteHost: cdnStaticWebsite.outputs.websiteHost
    suffix: suffix
    uniqueSuffix: uniqueSuffix
  }
}

module cdnDns 'modules/cdn/dns.bicep' = {
  name: 'deploy-cdn-dns'
  scope: resourceGroup(dnsResourceGroup)

  params: {
    customDomain: customDomain
    targetHostname: cdnProfile.outputs.endpointHostName
  }
}

module cdnCustomDomain 'modules/cdn/customDomain.bicep' = {
  name: 'deploy-cdn-custom-domain'

  params: {
    customDomain: customDomain
    endpointName: cdnProfile.outputs.endpointName
    endpointFullName: cdnProfile.outputs.endpointFullName
    location: location
    profileName: cdnProfile.outputs.profileName
    deploymentScriptIdentity: deploymentScriptsIdentity.outputs.msi
  }

  dependsOn: [ cdnDns ]
}
