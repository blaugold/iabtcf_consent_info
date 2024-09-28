import Flutter
import Foundation

public class IabtcfConsentInfoPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(
            name: "com.terwesten.gabriel/iabtcf_consent_info",
            binaryMessenger: registrar.messenger()
        )

        let instance = IabtcfConsentInfoPlugin()

        channel.setStreamHandler(instance)
    }

    private var events: FlutterEventSink!

    private var lastConsentInfoSent: [String: Any]?

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {

        self.events = events

        sendConsentInfo()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.userDefaultsDidChange),
            name: UserDefaults.didChangeNotification,
            object: nil
        )

        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(
            self,
            name: UserDefaults.didChangeNotification,
            object: nil
        )

        lastConsentInfoSent = nil

        events = nil

        return nil
    }

    @objc
    public func userDefaultsDidChange() {
        sendConsentInfo()
    }

    func sendConsentInfo() {
        let consentInfo = getConsentInfo()

        if (lastConsentInfoSent == nil || !NSDictionary(dictionary: consentInfo).isEqual(to: lastConsentInfoSent!)) {
            lastConsentInfoSent = consentInfo
            events(consentInfo)
        }
    }

    private func getConsentInfo() -> [String: Any] {
        UserDefaults.standard.dictionaryRepresentation()
            .filter { $0.key.hasPrefix("IABTCF_")}
    }
}
