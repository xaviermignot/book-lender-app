@description('The suffix to use in resource naming.')
param suffix string
param location string

resource deploymentScriptsMsi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'msi-${suffix}-deployment-scripts'
  location: location
}

resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
}

resource resourceGroupContributor 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: resourceGroup()
  name: guid(resourceGroup().id, deploymentScriptsMsi.id, contributorRoleDefinition.id)

  properties: {
    principalId: deploymentScriptsMsi.properties.principalId
    roleDefinitionId: contributorRoleDefinition.id
    principalType: 'ServicePrincipal'
  }
}

output msi object = {
  id: deploymentScriptsMsi.id
  principalId: deploymentScriptsMsi.properties.principalId
}
