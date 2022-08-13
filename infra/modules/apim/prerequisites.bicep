param uniqueSuffix string
param location string
@description('The default tags to assign to resources.')
param defaultTags object
param deploymentScriptIdentity object

var tags = union(defaultTags, { bicepModule: 'apim/prerequisites' })

resource getDomainOwnershipId 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'getApimDomainOwnershipId'
  location: location
  kind: 'AzureCLI'
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
    environmentVariables: [
      {
        name: 'baseUrl'
        value: '${environment().resourceManager}subscriptions/${subscription().subscriptionId}'
      }
    ]
    scriptContent: 'az rest -m post -u "$baseUrl/providers/Microsoft.ApiManagement/getDomainOwnershipIdentifier?api-version=2021-08-01" > $AZ_SCRIPTS_OUTPUT_PATH'
  }
}

output serviceName string = 'apim-${uniqueSuffix}'
output serviceDefaultHostname string = 'apim-${uniqueSuffix}.azure-api.net'
output domainOwnershipIdentifier string = getDomainOwnershipId.properties.outputs.domainOwnershipIdentifier
