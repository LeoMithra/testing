resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'trying8022'
  location: 'eastus'
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/schemas/2016-06-01/Microsoft.Logic.json',
      contentVersion: '1.0.0.0',
      parameters: {
        a: {
          type: 'Int',
          defaultValue: 10
        }
      },
      triggers: {
        Recurrence: {
          type: 'Recurrence',
          recurrence: {
            frequency: 'Minute',  // Changed to Minute
            interval: 10
          },
          runtimeConfiguration: {
            concurrency: {
              runs: 2,
              maximumWaitingRuns: 1
            }
          }
        }
      },
      variables: {  // Initialize the variable
        counter: 0
      },
      actions: {
        increment_variable: {
          type: 'IncrementVariable',
          inputs: {
            name: 'counter',   // This is the variable name, not the parameter
            value: '@parameters(''a'')'  // Use the parameter as increment value
          },
          runAfter: {}
        }
      }
    }
  }
}
