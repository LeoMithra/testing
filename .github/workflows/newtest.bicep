resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'try'
  location: 'westus'
  properties: {
    definition: {
      '$Schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'

      triggers: {
        reciever: {
          type: 'Request'
          kind: 'HTTP'
          inputs: {
            schema: {
              type: 'object'
              properties: {

                roleDes: { type: 'string' }

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
      }
      actions: {
        parse_Json: {
          type: 'ParseJson'
          inputs: {
            content: '@trigger().outputs.body'
            schema: {
              type: 'object'
              properties: { type: 'string' }
            }
          }
          runafter: {}
        }
        EmptyVar: {
          type: 'InitializeVariable'

          inputs: {
            variables: [
              {
                name: 'parse'
                type: 'String'
                value: '@outputs(\'parse_Json\').body.roleDes'
              }
            ]
          }
          runafter: { parse_Json: [ 'Succeeded' ] }
        }
      }
    }

  }
}
