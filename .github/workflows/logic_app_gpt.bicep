resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'trying8022'
  location: 'eastus'
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json'
      contentVersion: '1.0.0.0'
      parameters: {}
      triggers: {
        Recurrence: {
          type: 'Recurrence'
          recurrence: {
            frequency: 'Minute' // Changed to Minute
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
        InitializeVaribale: {
          type: 'InitializeVariable'

          inputs: {
            variables: {
              name: 'x'
              type: 'Integer'
              value: '13'
            }

          }
          runAfter: {}
        }
        increment_variable: {
          type: 'IncrementVariable'
          inputs: {
            name: 'x' // This is the variable name, not the parameter
            value: 10 // Use the parameter as increment value
          }
          runAfter: { InitializeVaribale: [ 'Succeeded' ] }
        }
      }
    }
  }
}
