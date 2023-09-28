resource YourLogicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'YourLogicAppName'
  location: resourceGroup().location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      actions: {
        getuserinfo: {
          inputs: {
            authentication: {
              CredentialType: 'Secret'
              audience: 'https://graph.microsoft.com/'
              clientId: '9a9f1fcb-40c2-4e32-b240-215eccbd271d'
              secret: 'E5s8Q~zvvNThmnhE8Haev8DLGvXGXS3ByjVE0awX'
              tenant: '0682f2e8-d86e-46a3-889b-3724d8b02485'
              type: 'ActiveDirectoryOAuth'
            }
            method: 'GET'
            uri: 'https://graph.microsoft.com/v1.0/users/@{triggerBody()?[\'user_email\']}'
          }
          runAfter: {}
          type: 'Http'
        }
      }
      contentVersion: '1.0.0.0'
      parameters: {}
      triggers: {
        reciever: {
          inputs: {
            schema: {
              properties: {
                user_email: {
                  type: 'string'
                }
                user_name: {
                  type: 'string'
                }
              }
              type: 'object'
            }
          }
          kind: 'Http'
          runtimeConfiguration: {
            concurrency: {
              maximumWaitingRuns: 3
              runs: 1
            }
          }
          type: 'Request'
        }
      }
    }
    parameters: {}
  }
}