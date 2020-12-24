# iabtcf_consent_info

[![](https://badgen.net/pub/v/iabtcf_consent_info)](https://pub.dev/packages/iabtcf_consent_info)

Flutter plugin for reading IAB TCF v2.0 user consent information, such as made available through CMP SDKs, like Funding 
Choices's User Messaging Platform (UMP).

Consent Management Platforms (CMPs) such as [Funding Choices](https://fundingchoices.google.com/start/) provide SDKs,
which publishers embed into their apps. These SDKs make consent information available to other pieces of
software in a [standardized way](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md).
This information can be read and listened to with the help of this plugin.

## Available Information

Currently, only a subset of the information provided by CMP SDKs is available through the plugin, primarily the
consent information related to data usage purposes of the publisher. Please open a new issue, if you need to access 
further information.

## Usage

Read the current consent information:

```dart
final info = await IabtcfConsentInfo.instance.currentConsentInfo();
if (info.publisherConsent.contains(DataUsagePurpose.developAndImproveProducts)) {
  // Do something which required consent.
}
```

Listen to changes of the consent information:

```dart
IabtcfConsentInfo.instance.consentInfo()
  // If you only want to react to changes skip the first value, 
  // since the stream always emits the current info when it is listened to.
  .skip(1).listen((info) { 
    // React to changes.  
});
```