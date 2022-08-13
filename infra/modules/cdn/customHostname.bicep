param customHostname string
param endpointName string
param endpointFullName string
param profileName string
param location string
param deploymentScriptIdentity object
@description('The default tags to assign to resources.')
param defaultTags object

var tags = union(defaultTags, { bicepModule: 'cdn/customHostname' })

resource staticWebsiteEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' existing = {
  name: endpointFullName
}

resource staticWebsiteCustomHostname 'Microsoft.Cdn/profiles/endpoints/customDomains@2021-06-01' = {
  name: 'customHostname'
  parent: staticWebsiteEndpoint

  properties: {
    hostName: customHostname
  }
}

resource enableHttps 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'enableHttps'
  kind: 'AzureCLI'
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${deploymentScriptIdentity.id}': {}
    }
  }

  properties: {
    retentionInterval: 'PT4H'
    azCliVersion: '2.37.0'
    scriptContent: 'az cdn custom-domain enable-https --endpoint-name ${endpointName} -n ${staticWebsiteCustomHostname.name} --profile-name ${profileName} -g ${resourceGroup().name}'
  }
}
