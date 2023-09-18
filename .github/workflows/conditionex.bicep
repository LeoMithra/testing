@allowed([
  'Dev'
  'Prod'
])
param env string
param deploy bool
param sName string
param location string

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (deploy) {
  name: sName
  location: location
  kind: 'StorageV2'

  sku: {
    name: env == 'prod' ? 'Standard_LRS' : 'Premium_LRS'
  }

}
