param suffix string
param location string
param name string
param msi object
param logicAppArmTemplate object
@description('The default tags to assign to resources.')
param defaultTags object

var tags = union(defaultTags, { bicepModule: 'logicApp' })

resource workflow 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'ala-${suffix}-${name}'
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${msi.id}': {}
    }
  }

  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
    }
  }
}

resource workflowDefinitionDeployment 'Microsoft.Resources/deployments@2021-04-01' = {
  name: 'deploy-ala-${name}-definition'
  tags: tags

  properties: {
    mode: 'Incremental'

    parameters: {
      logicAppName: {
        value: workflow.name
      }
    }

    template: any(logicAppArmTemplate)
  }
}
