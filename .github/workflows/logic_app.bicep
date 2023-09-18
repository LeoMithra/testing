resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'trying8022'
  location: 'eastus'
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      parameters: {
        a: 10
      }
      trigger: {
        Recurrence: {
          type: 'Recurrence'
          input: {
            frequency: 'sec'
            interval: 10
          }
          runtimeConfiguration: {
            concurrency: {
              runs: 2
              maximumWaitingRuns: 1
            }
          }
        }
      }
      actions: {
        increment_varibale: {
          inputs: {
            name: 'a'
            value: 5
          }
          runAfter: {}
        }
      }
    }
  }
}
