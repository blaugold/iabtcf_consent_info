import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:iabtcf_consent_info_platform_interface/iabtcf_consent_info_platform_interface.dart';
import 'package:rxdart/rxdart.dart';

/// Data usage purpose as defined by the IAB TCF framework.
///
/// See:
/// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#A_Purposes)
enum DataUsagePurpose {
  /// Store and/or access information on a device
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_1__Store_andor_access_information_on_a_device)
  storeAndAccessInformationOnADevice,

  /// Select basic ads
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_2__Select_basic_ads_)
  selectBasicAds,

  /// Create a personalised ads profile
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_3__Create_a_personalised_ads_profile)
  createAPersonalisedAdsProfile,

  /// Select personalised ads
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_4__Select_personalised_ads)
  selectPersonalisedAds,

  /// Create a personalised content profile
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_5__Create_a_personalised_content_profile)
  createAPersonalisedContentProfile,

  /// Select personalised content
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_6__Select_personalised_content)
  selectPersonalisedContent,

  /// Measure ad performance
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_7__Measure_ad_performance)
  measureAdPerformance,

  /// Measure content performance
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_8__Measure_content_performance)
  measureContentPerformance,

  /// Apply market research to generate audience insights
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_9__Apply_market_research_to_generate_audience_insights_)
  applyMarketResearchToGenerateAudienceInsights,

  /// Develop and improve products
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/#Purpose_10__Develop_and_improve_products)
  developAndImproveProducts,

  /// Use limited data to select content
  ///
  /// See:
  /// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies)
  useLimitedDataToSelectContent,
}

/// Minimal IAB TCF consent information which is available when a CMP SDK has
/// been initialized.
@immutable
class BasicConsentInfo {
  /// Creates minimal IAB TCF consent information which is available when a CMP
  /// SDK has been initialized.
  const BasicConsentInfo({
    required this.raw,
    required this.sdkId,
    required this.sdkVersion,
    required this.policyVersion,
    required this.gdprApplies,
  });

  /// The id of the CMP SDK, which provided this consent information.
  final int sdkId;

  /// The version of the CMP SDK which provided this consent information, if
  /// available.
  final int? sdkVersion;

  /// The unsigned integer representing the version of the TCF that these
  /// consents adhere to, if available.
  final int? policyVersion;

  /// Whether GDPR applies for the user in the current context.
  ///
  /// While the CMP SDK is in the process of determining if GDPR applies, this
  /// property is `null`.
  ///
  /// See:
  /// - [What does the gdprApplies value mean?](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#what-does-the-gdprapplies-value-mean)
  final bool? gdprApplies;

  /// The raw consent info returned from the CMD SDK.
  ///
  /// [==], [hashCode], and [toString] do not take this value into account.
  final Map<String, dynamic> raw;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasicConsentInfo &&
          runtimeType == other.runtimeType &&
          sdkId == other.sdkId &&
          sdkVersion == other.sdkVersion &&
          policyVersion == other.policyVersion &&
          gdprApplies == other.gdprApplies;

  @override
  int get hashCode =>
      sdkId.hashCode ^
      sdkVersion.hashCode ^
      policyVersion.hashCode ^
      gdprApplies.hashCode;

  @override
  String toString() => 'BasicConsentInfo('
      'sdkId: $sdkId, '
      'sdkVersion: $sdkVersion, '
      'policyVersion: $policyVersion, '
      'gdprApplies: $gdprApplies'
      ')';
}

/// IAB TCF consent information which is provided by a CMP SDK.
///
/// See:
/// - [TCF v2.0](https://iabeurope.eu/tcf-2-0/)
/// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/)
@immutable
class ConsentInfo extends BasicConsentInfo {
  /// Create IAB TCF consent information which is provided by a CMP SDK.
  const ConsentInfo({
    required Map<String, dynamic> raw,
    required int sdkId,
    required int? sdkVersion,
    required int? policyVersion,
    required bool? gdprApplies,
    required this.purposeConsents,
    required this.purposeLegitimateInterests,
    required this.publisherConsents,
    required this.publisherLegitimateInterests,
  }) : super(
          raw: raw,
          sdkId: sdkId,
          sdkVersion: sdkVersion,
          policyVersion: policyVersion,
          gdprApplies: gdprApplies,
        );

  /// The [DataUsagePurpose]s for advertising for which a legal basis of
  /// consent exists.
  final List<DataUsagePurpose> purposeConsents;

  /// The [DataUsagePurpose]s for advertising for which a legal basis of
  /// legitimate interests exists.
  final List<DataUsagePurpose> purposeLegitimateInterests;

  /// The [DataUsagePurpose]s for which the publisher has a legal basis of
  /// consent.
  final List<DataUsagePurpose> publisherConsents;

  /// The [DataUsagePurpose]s for which the publisher has a legal basis of
  /// legitimate interests.
  final List<DataUsagePurpose> publisherLegitimateInterests;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentInfo &&
          runtimeType == other.runtimeType &&
          super == other &&
          listEquals(purposeConsents, other.purposeConsents) &&
          listEquals(
            purposeLegitimateInterests,
            other.purposeLegitimateInterests,
          ) &&
          listEquals(publisherConsents, other.publisherConsents) &&
          listEquals(
            publisherLegitimateInterests,
            other.publisherLegitimateInterests,
          );

  @override
  int get hashCode =>
      super.hashCode ^
      purposeConsents.hashCode ^
      purposeLegitimateInterests.hashCode ^
      publisherConsents.hashCode ^
      publisherLegitimateInterests.hashCode;

  @override
  String toString() => 'ConsentInfo('
      'sdkId: $sdkId, '
      'sdkVersion: $sdkVersion, '
      'policyVersion: $policyVersion, '
      'gdprApplies: $gdprApplies, '
      'purposeConsents: $purposeConsents, '
      'purposeLegitimateInterests: $purposeLegitimateInterests, '
      'publisherConsents: $publisherConsents, '
      'publisherLegitimateInterests: $publisherLegitimateInterests'
      ')';
}

// Keys in the raw information made available by a CMP SDK.
const _cmpSdkIDKey = 'IABTCF_CmpSdkID';
const _cmpSdkVersionKey = 'IABTCF_CmpSdkVersion';
const _policyVersionKey = 'IABTCF_PolicyVersion';
const _gdprAppliesKey = 'IABTCF_gdprApplies';
const _purposeConsentsKey = 'IABTCF_PurposeConsents';
const _purposeLegitimateInterestsKey = 'IABTCF_PurposeLegitimateInterests';
const _publisherConsentKey = 'IABTCF_PublisherConsent';
const _publisherLegitimateInterestKey = 'IABTCF_PublisherLegitimateInterests';

/// Create [BasicConsentInfo] from the raw consent information, which is made
/// available by an CMP SDK.
BasicConsentInfo? parseRawConsentInfo(Map<String, dynamic> raw) {
  final sdkId = raw[_cmpSdkIDKey] as int?;

  // The sdk id should be set as early as possible by the CMP sdk to
  // signal its existence.
  // https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#in-app-details
  if (sdkId == null) {
    return null;
  }

  final sdkVersion = raw[_cmpSdkVersionKey] as int?;
  final policyVersion = raw[_policyVersionKey] as int?;
  final gdprApplies = (raw[_gdprAppliesKey] as int?)?.let(_parseNumberAsBool);

  if (gdprApplies != true) {
    return BasicConsentInfo(
      raw: raw,
      sdkId: sdkId,
      sdkVersion: sdkVersion,
      policyVersion: policyVersion,
      gdprApplies: gdprApplies,
    );
  }

  List<DataUsagePurpose> parseDataUsagePurposes(Object? info) =>
      (info as String?)?.let(_parseDataUsagePurposeBinaryString) ?? [];

  return ConsentInfo(
    raw: raw,
    sdkId: sdkId,
    sdkVersion: sdkVersion,
    policyVersion: policyVersion,
    gdprApplies: true,
    purposeConsents: parseDataUsagePurposes(raw[_purposeConsentsKey]),
    purposeLegitimateInterests:
        parseDataUsagePurposes(raw[_purposeLegitimateInterestsKey]),
    publisherConsents: parseDataUsagePurposes(raw[_publisherConsentKey]),
    publisherLegitimateInterests:
        parseDataUsagePurposes(raw[_publisherLegitimateInterestKey]),
  );
}

/// Parses an [int] as a [bool].
bool _parseNumberAsBool(int value) {
  assert(value == 0 || value == 1);
  return value == 0 ? false : true;
}

/// Takes a string of only `0`s and `1`s, and returns the 0-based indices of
/// the `1`s.
List<int> _parseBinaryString(String string) => string
    .split('')
    .asMap()
    .entries
    .where((it) => it.value == '1')
    .map((it) => it.key)
    .toList();

List<DataUsagePurpose> _parseDataUsagePurposeBinaryString(String string) =>
    _parseBinaryString(string)
        .map((it) => DataUsagePurpose.values[it])
        .toList();

/// Plugin for reading locally stored IAB TCF consent information, provided by a
/// CMP SDK.
class IabtcfConsentInfo {
  /// Private constructor to enforce singleton [instance].
  IabtcfConsentInfo._();

  /// The singleton instance of this plugin.
  static late final instance = IabtcfConsentInfo._();

  // ignore: close_sinks
  late final _consentInfo = ReplaySubject<BasicConsentInfo?>(
    maxSize: 1,
    onListen: _onConsentInfoListen,
    onCancel: _onConsentInfoCancel,
  );

  late StreamSubscription<void> _rawConsentInfoSub;

  void _onConsentInfoListen() {
    _rawConsentInfoSub = IabtcfConsentInfoPlatform.instance
        .rawConsentInfo()
        .map(parseRawConsentInfo)
        .listen(_consentInfo.add, onError: _consentInfo.addError);
  }

  Future<void> _onConsentInfoCancel() => _rawConsentInfoSub.cancel();

  /// Returns a stream which emits every time consent info changes.
  ///
  /// If no CMP has registered consent information, the stream emits `null`.
  ///
  /// If the GDPR does not apply or whether it does has not been determined yet
  /// [BasicConsentInfo] is emitted. Once the full consent info is available
  /// [ConsentInfo] is emitted.
  ///
  /// The first value emitted by the stream is the current consent information
  /// and does not signal a change.
  Stream<BasicConsentInfo?> consentInfo() => _consentInfo;

  /// Returns a [Future] which resolves to the current [ConsentInfo].
  ///
  /// If no CMP has registered consent information, the Future resolves to
  /// `null`.
  ///
  /// If the GDPR does not apply or whether it does has not been determined yet
  /// [BasicConsentInfo] is returned. If the full consent info is available
  /// [ConsentInfo] is returned.
  Future<BasicConsentInfo?> currentConsentInfo() => consentInfo().first;
}

extension _ValueExt<T> on T {
  /// Apply this value to [fn] and return the result.
  R let<R>(R Function(T) fn) => fn(this);
}
