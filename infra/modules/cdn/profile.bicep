param suffix string
param location string
param staticWebsiteHost string

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: 'cdnp-${suffix}'
  location: location

  sku: {
    name: 'Standard_Microsoft'
  }
}

resource staticWebsiteEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  name: 'cdne-${suffix}-web'
  location: location
  parent: profile

  properties: {
    origins:  [
      {
        name: 'static-http'
        properties: {
          hostName: staticWebsiteHost
        }
      } 
    ]
  }
}
