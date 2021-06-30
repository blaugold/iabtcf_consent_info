/*
 * Mock implementation of an CMP SDK for testing.
 */

const testTcData = {
  listenerId: 0,
  cmpId: 0,
  cmpVersion: 0,
  tcfPolicyVersion: 2,
  gdprApplies: true,
  tcString: 'test',
  isServiceSpecific: true,
  useNonStandardStacks: false,
  purposeOneTreatment: false,
  publisherCC: 'AA',
  outOfBand: {
    allowedVendors: {},
    disclosedVendors: {},
  },
  purpose: {
    consents: {},
    legitimateInterests: {},
  },
  vendor: {
    consents: {},
    legitimateInterests: {},
  },
  specialFeatureOptions: {},
  publisher: {},
  publisher: {
    consents: {},
    legitimateInterests: {},
    customPurpose: {
      consents: {},
      legitimateInterests: {},
    },
    restrictions: {},
  },
}

window.__tcfapi = function (command, version, callback, parameter) {
  if (version !== 2) {
    throw Error(`Unexpected version: ${version}`)
  }

  if (typeof callback !== 'function') {
    throw Error(`Expected callback but received: ${callback}`)
  }

  switch (command) {
    case 'addEventListener':
      const listener = callback

      // Send test data.
      callback(testTcData, true)

      break
    case 'removeEventListener':
      const listenerId = parameter
      if (typeof listenerId !== 'number') {
        throw Error(`Expected listenerId, but received: ${listenerId}`)
      }

      // Signal that listener was removed.
      callback(true)

      break
    default:
      throw Error(`Unexpected command: ${command}`)
  }
}
