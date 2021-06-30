import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    setupTestConsentInfo()
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

func setupTestConsentInfo() {
    UserDefaults.standard.setValuesForKeys([
        "IABTCF_CmpSdkID": 0,
        "IABTCF_CmpSdkVersion": 0,
        "IABTCF_PolicyVersion": 2,
        "IABTCF_gdprApplies": 1,
        "IABTCF_UseNonStandardStacks": 0,
        "IABTCF_PublisherCC": "AA",
        "IABTCF_TCString": "test"
    ])
}
