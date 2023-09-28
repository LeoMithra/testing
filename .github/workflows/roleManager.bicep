resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'RoleManager'
  location: 'westus'
  properties: {
    definition: {
      '$Schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      parameter: {}
      trigger: {
        type: 'Request'
        kind: 'HTTP'
        input: {
          schema: {
            type: 'object'
            properties: {
              approle: {
                type: 'array'
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
        getGUID: {
          type: 'HTTP'
          runsafter: {}
          inputs: {
            method: 'Get'
            uri: 'https://www.uuidtools.com/api/generate/v4'
          }
        }
        parse_Json: {
          type: 'ParseJson'
          inputs: {
            content: '@outputs.(\'getGUID\').body'
            schema: {
              items: { type: 'string' }
              type: 'array'
            }
          }
          runafter: { getGUID: [ 'Successed' ] }

        }
        Guid: {
          type: 'InitializeVariable'
          inputs: {
            variables: {
              name: 'guid'
              type: 'string'
              value: '@outputs(\'parse_Json\').items'
            }
          }
          runafter: { parse_Json: [ 'Successed' ] }
        }
        getAppinfo: {
          type: 'HTTP'
          inputs: {
            method: 'Get'
            uri: 'https://graph.microsoft.com/v1.0/applications/d714c127-faa1-4edb-89c7-bb3a487a7940/appRoles'
            authentication: {
              type: 'ActiveDirectoryOAuth'
              tenant: '0682f2e8-d86e-46a3-889b-3724d8b02485'
              audience: 'https://graph.microsoft.com/'
              clientId: '38130f7e-7f61-48e3-9b49-410e1542edf2'
              CredentialType: 'Secret'
              secret: 'X_Z8Q~~q0m7jZPilBhd~DiYXgj9tfscE5xvR1dkS'
            }
          }
          runafter: { Guid: [ 'Successed' ] }
        }
        Parse_role: {
          type: 'ParseJson'
          runafter: { getAppinfo: [ 'Successed' ] }
          content: '@outputs(\'getAppinfo\').body'
          schema: {
            type: 'object'
            properties: {
              '@@odata.context': {
                type: 'string'
              }
              value: { type: 'object' }
            }
          }
        }
        RoleObj: {
          inputs: {
            variables: {
              name: 'guid'
              type: 'array'
              value: '@outputs(\'parse_Json\').value'
            }
          }
          runafter: { parse_Json: [ 'Successed' ] }
        }
        AppendNewRole: {
          type: 'AppendToArrayVariable'
          inputs: {
            variableName: 'RoleObj'
            value: '@trigger().output.body.appRoles'
          }
          runAfter: {
            RolesObj: [ 'Succeeded' ]
          }
          sendRequest: {
            type: 'HTTP'
            runafter: { AppendNewRole: [ 'Successed' ] }
            inputs: {
              method: 'Patch'
              inputs: {
                uri: 'https://graph.microsoft.com/beta/applications/d714c127-faa1-4edb-89c7-bb3a487a7940/appRoles'
                body: '@outputs(\'AppendNewRole\').RoleObj'
                authentication: {
                  type: 'ActiveDirectoryOAuth'
                  tenant: '0682f2e8-d86e-46a3-889b-3724d8b02485'
                  audience: 'https://graph.microsoft.com/'
                  clientId: '38130f7e-7f61-48e3-9b49-410e1542edf2'
                  CredentialType: 'Secret'
                  secret: 'X_Z8Q~~q0m7jZPilBhd~DiYXgj9tfscE5xvR1dkS'
                }
              }

            }
          }
        }
      }

    }
  }
}
