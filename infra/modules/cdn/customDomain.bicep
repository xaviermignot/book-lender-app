param customDomain string
param endpointName string
param endpointFullName string
param profileName string
param location string
param deploymentScriptIdentity object

resource staticWebsiteEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' existing = {
  name: endpointFullName
}

resource staticWebsiteCustomDomain 'Microsoft.Cdn/profiles/endpoints/customDomains@2021-06-01' = {
  name: 'customDomain'
  parent: staticWebsiteEndpoint

  properties: {
    hostName: customDomain
  }
}

resource enableHttps 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'enableHttps'
  kind: 'AzureCLI'
  location: location

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${deploymentScriptIdentity.id}': {}
    }
  }

  properties: {
    retentionInterval: 'PT4H'
    azCliVersion: '2.37.0'
    scriptContent: 'az cdn custom-domain enable-https --endpoint-name ${endpointName} -n ${staticWebsiteCustomDomain.name} --profile-name ${profileName} -g ${resourceGroup().name}'
  }
}
