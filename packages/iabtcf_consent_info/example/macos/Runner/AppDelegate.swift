import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationDidFinishLaunching(_ notification: Notification) {
        setupTestConsentInfo()
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

func setupTestConsentInfo() {
    UserDefaults.standard.setValuesForKeys([
        "IABTCF_CmpSdkID": 0,
        "IABTCF_CmpSdkVersion": 0,
        "IABTCF_PolicyVersion": 2,
        "IABTCF_gdprApplies": 1,
        "IABTCF_PublisherConsent": "0101010101",
        "IABTCF_PublisherLegitimateInterests": "0101010101",
    ])
}
