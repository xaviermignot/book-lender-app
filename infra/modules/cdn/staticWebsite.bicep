param uniqueSuffix string
param location string
param deploymentScriptIdentity object
@description('The default tags to assign to resources.')
param defaultTags object

var tags = union(defaultTags, { bicepModule: 'cdn/staticWebsite' })

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: substring('stor${replace(uniqueSuffix, '-', '')}', 0, 24)
  location: location
  tags: tags

  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

resource contributorRoleDefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  // This is the Storage Account Contributor role, which is the minimum role permission we can give.
  // See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#:~:text=17d1049b-9a84-46fb-8f53-869881c3d3ab
  name: '17d1049b-9a84-46fb-8f53-869881c3d3ab'
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  scope: storageAccount
  name: guid(resourceGroup().id, deploymentScriptIdentity.id, contributorRoleDefinition.id)
  properties: {
    roleDefinitionId: contributorRoleDefinition.id
    principalId: deploymentScriptIdentity.principalId
    principalType: 'ServicePrincipal'
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'enableStaticWebsite'
  kind: 'AzureCLI'
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${deploymentScriptIdentity.id}': {}
    }
  }

  dependsOn: [ roleAssignment ]

  properties: {
    retentionInterval: 'PT4H'
    azCliVersion: '2.37.0'
    scriptContent: 'az storage blob service-properties update --account-name ${storageAccount.name} --static-website --404-document 404.html --index-document index.html'
  }
}

output websiteHost string = replace(replace(storageAccount.properties.primaryEndpoints.web, 'https://', ''), '/', '')
