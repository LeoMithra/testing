using './dec_cond.bicep'

param location = 'westus'
param sqlServerAdministratorLogin = 'gitcreation1231'
param sqlServerAdministratorLoginPassword = 'gitcreation1231'
param sqlDatabaseSku = {
  name: 'Standard'
  tier: 'Standard'
}
param environmentName = 'Development'
param auditStorageAccountSkuName = 'Standard_LRS'
