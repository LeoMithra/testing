resource Outlook 'Microsoft.Web/connections@2016-06-01' = {
  name: 'outlookconnection'
  location: 'westus'

  properties: {
    api: any({
      id: subscriptionResourceId('Microsoft.Web/locations/managedApis', 'westus', 'office365')
    })
  }
}

resource Outlookex 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'name'
  location: 'westus'
  properties: {
    definition: {
      '': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      triggers:{
        WhenemailArrives:{
          type:'OnNewEmailV3'
          {
            
          }
        }
      }



    }
  }
}
