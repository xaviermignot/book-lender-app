param record object
param zoneName string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: zoneName
}

resource cnameRecord 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: record.name
  parent: dnsZone

  properties: {
    TTL: 300
    CNAMERecord: {
      cname: record.value
    }
  }
}
