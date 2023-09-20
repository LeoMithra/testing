resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'Userinfo'
  location: 'westus'
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      triggers: {
        reciever: {
          type: 'Request'
          kind: 'HTTP'
          inputs: {
            schema: {
              type: 'object'
              properties: {
                user_name: { type: 'string' }
                user_email: { type: 'string' }
              }
            }
          }
        }
        runtimeConfiguration: {
          concurrency: {
            runs: 1
            maximumWaitingRuns: 3
          }
        }
      }
      actions: {
        getuserinfo: {
          type: 'HTTP'
          runAfter: {}
          inputs: {
            method: 'GET'
            uri: 'https://graph.microsoft.com/v1.0/users/@triggerOutput()[body/user_email]'
            authentication: {
              type: 'ActiveDirectoryOAuth'
              tenant: '0682f2e8-d86e-46a3-889b-3724d8b02485'
              audience: 'https://graph.microsoft.com/'
              clientId: '9a9f1fcb-40c2-4e32-b240-215eccbd271d'
              CredentialType: 'Secret'
              secret: 'E5s8Q~zvvNThmnhE8Haev8DLGvXGXS3ByjVE0awX'
            }
          }

        }

      }

    }
  }
}
