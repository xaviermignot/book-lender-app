param suffix string
param uniqueSuffix string
param location string
param staticWebsiteHost string
@description('The default tags to assign to resources.')
param defaultTags object

var tags = union(defaultTags, { bicepModule: 'cdn/profile' })

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: 'cdnp-${suffix}'
  location: location
  tags: tags

  sku: {
    name: 'Standard_Microsoft'
  }
}

resource staticWebsiteEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  name: 'cdne-${uniqueSuffix}-web'
  location: location
  parent: profile
  tags: tags

  properties: {
    origins: [
      {
        name: 'static-http'
        properties: {
          hostName: staticWebsiteHost
        }
      }
    ]
  }
}

output endpointName string = staticWebsiteEndpoint.name
output endpointFullName string = '${profile.name}/${staticWebsiteEndpoint.name}'
output endpointHostName string = staticWebsiteEndpoint.properties.hostName
output profileName string = profile.name
