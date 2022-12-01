/*
 * Mock implementation of an CMP SDK for testing.
 */

const testTcData = {
    listenerId: 0,
    cmpId: 0,
    cmpVersion: 0,
    tcfPolicyVersion: 2,
    tcString: 'tcString',
    gdprApplies: true,
    purpose: {
        consents: {
            1: false,
            2: true,
            3: false,
            4: true,
            5: false,
            6: true,
            7: false,
            8: true,
            9: false,
            10: true,
        },
        legitimateInterests: {
            1: false,
            2: true,
            3: false,
            4: true,
            5: false,
            6: true,
            7: false,
            8: true,
            9: false,
            10: true,
        }
    },
    publisher: {
        consents: {
            1: false,
            2: true,
            3: false,
            4: true,
            5: false,
            6: true,
            7: false,
            8: true,
            9: false,
            10: true,
        },
        legitimateInterests: {
            1: false,
            2: true,
            3: false,
            4: true,
            5: false,
            6: true,
            7: false,
            8: true,
            9: false,
            10: true,
        }
    }
}

window.__tcfapi = function (command, version, callback, parameter) {
    if (version !== 2) {
        throw Error(`Unexpected version: ${version}`);
    }

    if (typeof callback !== 'function') {
        throw Error(`Expected callback but received: ${callback}`);
    }

    switch (command) {
        case 'addEventListener':
            const listener = callback;

            // Send test data.
            callback(testTcData, true)

            break;
        case 'removeEventListener':
            const listenerId = parameter;
             if (typeof listenerId !== 'number') {
                throw Error(`Expected listenerId, but received: ${listenerId}`);
            }

            // Signal that listener was removed.
            callback(true);

            break;
        default:
            throw Error(`Unexpected command: ${command}`);
    }
}
