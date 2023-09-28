resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'name'
  location: location
  properties: {
    definition: {
      '$Schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      trigger:{
        HTTP:{
          type:'HTTP'
          inputs:{
            method:'Post'
            uri:'<Azure end point to get token>'
            authentication:{
              type:'ActiveDirectoryOAuth'
              tenant: ''
              audience:''
              clientId:''
              CredentialType:''
              secret:''
            }
            runtimeConfiguration: {
              concurrency: {
                runs: 2
                maximumWaitingRuns: 1
              }


          }
          
        }



      }


    }
  }
}
