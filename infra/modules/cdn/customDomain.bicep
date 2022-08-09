param customDomain string
param endpointName string

resource staticWebsiteEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' existing = {
  name: endpointName
}

resource staticWebsiteCustomDomain 'Microsoft.Cdn/profiles/endpoints/customDomains@2021-06-01' = {
  name: 'customDomain'
  parent: staticWebsiteEndpoint

  properties: {
    hostName: customDomain
  }
}
