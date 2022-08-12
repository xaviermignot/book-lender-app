param customDomain string
param targetHostname string

var hostSegments = split(customDomain, '.')
var dnsZoneName = join(skip(hostSegments, 1), '.')
var dnsCnameRecord = hostSegments[0]

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: dnsZoneName
}

resource cnameRecord 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: dnsCnameRecord
  parent: dnsZone

  properties: {
    TTL: 300
    CNAMERecord: {
      cname: targetHostname
    }
  }
}
