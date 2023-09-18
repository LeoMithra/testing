param location string
param SqlServerName string
param admin_userName string

@secure()
@description('enter the password')
param admin_Password string

@allowed([
  'dev'
  'prod'
])
param env string

param dbname string

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: SqlServerName
  location: location

  properties: {
    administratorLogin: admin_userName
    administratorLoginPassword: admin_Password
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2023-02-01-preview' = {
  parent: sqlServer
  name: dbname
  location: location

}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (env == 'prod') {
  name: 'auditstorageaccount8025'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource sqlAuditServer 'Microsoft.Sql/servers/auditingSettings@2022-11-01-preview' = if (env == 'prod') {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: storageaccount.properties.primaryEndpoints.blob
    storageAccountAccessKey: env == 'prod' ? storageaccount.listKeys(storageaccount.apiVersion).keys[0].value : ''
  }
}
