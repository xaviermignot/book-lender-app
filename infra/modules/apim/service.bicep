param uniqueSuffix string
param location string
@description('The default tags to assign to resources.')
param defaultTags object
@description('The contact information about the APIM publisher.')
param publisher object
param apiCustomDomain string

var tags = union(defaultTags, { bicepModule: 'apim/service' })

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: 'apim-${uniqueSuffix}'
  location: location
  tags: tags

  sku: {
    capacity: 0
    name: 'Consumption'
  }

  properties: {
    publisherEmail: publisher.email
    publisherName: publisher.name

    hostnameConfigurations: [
      {
        hostName: apiCustomDomain
        type: 'Proxy'
        certificateSource: 'Managed'
      }
    ]
  }
}
