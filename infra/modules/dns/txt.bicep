param record object
param zoneName string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: zoneName
}

resource txtRecord 'Microsoft.Network/dnsZones/TXT@2018-05-01' = {
  name: record.name
  parent: dnsZone

  properties: {
    TTL: 300
    TXTRecords: [
      {
        value: [ record.value ]
      }
    ]
  }
}
