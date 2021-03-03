import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:iabtcf_consent_info_platform_interface/iabtcf_consent_info_platform_interface.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// Data usage purpose as defiend by the IABTCF framework.
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
}

List<DataUsagePurpose> _parseDataUsagePurposeBinaryString(String string) =>
    _parseBinaryString(string)
        .map((it) => DataUsagePurpose.values[it])
        .toList();

// Keys in the raw information made available by a CMP SDK.
const _cmpSdkIDKey = 'IABTCF_CmpSdkID';
const _cmpSdkVersionKey = 'IABTCF_CmpSdkVersion';
const _policyVersionKey = 'IABTCF_PolicyVersion';
const _gdprAppliesKey = 'IABTCF_gdprApplies';
const _publisherConsentKey = 'IABTCF_PublisherConsent';
const _publisherLegitimateInterestKey = 'IABTCF_PublisherLegitimateInterests';

/// IABTCF consent information which is provided by a CMP SDK.
///
/// See:
/// - [TCF v2.0](https://iabeurope.eu/tcf-2-0/)
/// - [Policy](https://iabeurope.eu/iab-europe-transparency-consent-framework-policies/)
@immutable
class ConsentInfo {
  /// Create IABTCF consent information which is provided by a CMP SDK.
  const ConsentInfo({
    required this.sdkId,
    required this.sdkVersion,
    required this.policyVersion,
    required this.gdprApplies,
    required this.publisherConsent,
    required this.publisherLegitimateInterests,
  });

  /// Create [ConsentInfo] from the raw consent information, which is made
  /// available by an CMP SDK.
  factory ConsentInfo.parseRawInfo(Map<String, dynamic> rawInfo) {
    List<DataUsagePurpose> parseDataUsagePurpose(Object? info) =>
        (info as String?)?.let(_parseDataUsagePurposeBinaryString) ?? [];

    return ConsentInfo(
      sdkId: rawInfo[_cmpSdkIDKey] as int,
      sdkVersion: rawInfo[_cmpSdkVersionKey] as int,
      policyVersion: rawInfo[_policyVersionKey] as int,
      gdprApplies: (rawInfo[_gdprAppliesKey] as int?)?.let(_parseNumberAsBool),
      publisherConsent: parseDataUsagePurpose(rawInfo[_publisherConsentKey]),
      publisherLegitimateInterests:
          parseDataUsagePurpose(rawInfo[_publisherLegitimateInterestKey]),
    );
  }

  /// The id of the CMP SDK which provided this consent information.
  final int sdkId;

  /// The version of the CMP SDK which provided this consent information.
  final int sdkVersion;

  /// The unsigned integer representing the version of the TCF that these
  /// consents adhere to.
  final int policyVersion;

  /// Whether or not GDPR applies in its current context.
  ///
  /// See:
  /// - [What does the gdprApplies value mean?](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#what-does-the-gdprapplies-value-mean)
  final bool? gdprApplies;

  /// The [DataUsagePurpose]s for which the publisher has a legal basis of
  /// consent.
  final List<DataUsagePurpose> publisherConsent;

  /// The [DataUsagePurpose]s for which the publisher has a legal basis of
  /// legitimate interests.
  final List<DataUsagePurpose> publisherLegitimateInterests;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentInfo &&
          runtimeType == other.runtimeType &&
          sdkId == other.sdkId &&
          sdkVersion == other.sdkVersion &&
          policyVersion == other.policyVersion &&
          gdprApplies == other.gdprApplies &&
          listEquals(publisherConsent, other.publisherConsent) &&
          listEquals(
            publisherLegitimateInterests,
            other.publisherLegitimateInterests,
          );

  @override
  int get hashCode =>
      sdkId.hashCode ^
      sdkVersion.hashCode ^
      policyVersion.hashCode ^
      gdprApplies.hashCode ^
      publisherConsent.hashCode ^
      publisherLegitimateInterests.hashCode;

  @override
  String toString() => 'ConsentInfo('
      'sdkId: $sdkId, '
      'sdkVersion: $sdkVersion, '
      'policyVersion: $policyVersion, '
      'gdprApplies: $gdprApplies, '
      'publisherConsent: $publisherConsent, '
      'publisherLegitimateInterests: $publisherLegitimateInterests)';
}

/// Plugin for reading locally stored IABTCF consent information, provided by a
/// CMP SDK.
class IabtcfConsentInfo {
  /// Private constructor to enforce singleton [instance].
  IabtcfConsentInfo._();

  /// The singleton instance of this plugin.
  static late final instance = IabtcfConsentInfo._();

  late final _publishedStream = ReplaySubject<ConsentInfo?>(
    maxSize: 1,
    onListen: _onPublishedStreamListen,
    onCancel: _onPublishedStreamCancel,
  );

  late StreamSubscription<void> _rawInfoSub;

  void _onPublishedStreamListen() {
    _rawInfoSub = IabtcfConsentInfoPlatform.instance
        .rawConsentInfo()
        .map((rawInfo) =>
            // The sdk id should be set as early as possible by the CMP sdk to
            // signal its existence.
            // https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#in-app-details
            !rawInfo.containsKey(_cmpSdkIDKey)
                ? null
                : ConsentInfo.parseRawInfo(rawInfo))
        .listen(_publishedStream.add);
  }

  Future<void> _onPublishedStreamCancel() async {
    await _rawInfoSub.cancel();
  }

  /// Returns a stream which emits every time [ConsentInfo] changes.
  ///
  /// If no CMP has registered consent information, the stream emits `null`.
  ///
  /// The first value emitted by the stream is the current consent information
  /// and does not signal a change.
  Stream<ConsentInfo?> consentInfo() => _publishedStream;

  /// Returns a [Future] which resolves to the current [ConsentInfo].
  ///
  /// If no CMP has registered consent information, the Future resolves to
  /// `null`.
  Future<ConsentInfo?> currentConsentInfo() => consentInfo().first;
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

/// Parses an [int] as a [bool].
bool _parseNumberAsBool(int value) {
  assert(value == 0 || value == 1);
  return value == 0 ? false : true;
}

extension _ValueExt<T> on T {
  /// Apply this value to [fn] and return the result.
  R let<R>(R Function(T) fn) => fn(this);
}
