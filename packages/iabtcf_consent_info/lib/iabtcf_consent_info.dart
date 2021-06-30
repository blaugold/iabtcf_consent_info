import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iabtcf_consent_info_platform_interface/iabtcf_consent_info_platform_interface.dart';
import 'package:meta/meta.dart';
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
}

/// Minimal IAB TCF consent information which is available when a CMP SDK has
/// been initialized.
@immutable
class BasicConsentInfo with Diagnosticable {
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
  // ignore: diagnostic_describe_all_properties
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('sdkId', sdkId))
      ..add(IntProperty('sdkVersion', sdkVersion))
      ..add(IntProperty('policyVersion', policyVersion))
      ..add(FlagProperty(
        'gdprApplies',
        value: gdprApplies,
        ifTrue: 'GDPR APPLIES',
        ifFalse: 'GDPR DOES NOT APPLY',
      ));
  }
}

/// Treatment of Purpose 1.
enum PurposeOneTreatment {
  /// There is no special Purpose 1 treatment status.
  ///
  /// Purpose 1 was disclosed normally (consent) as expected by TCF Policy.
  normal,

  /// Purpose 1 not disclosed at all.
  ///
  /// CMPs use PublisherCC to indicate the publisher's country of establishment
  /// to help vendors to determine whether the vendor requires Purpose 1
  /// consent.
  special,
}

/// One of the features of processing personal data for which the user is given
/// the choice to opt-in.
enum SpecialFeature {
  /// Use precise geolocation data.
  usePreciseGeolocationData,

  /// Actively scan device characteristics for identification.
  activelyScanDeviceCharacteristics
}

/// Restriction on the use of a vendor.
enum VendorRestriction {
  /// Not Allowed
  notAllowed,

  /// Require Consent
  requireConsent,

  /// Require Legitimate Interest
  requireLegitimateInterest,
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
    required this.tcString,
    required this.isServiceSpecific,
    required this.useNonStandardStacks,
    required this.publisherCC,
    required this.purposeOneTreatment,
    required this.purposeConsents,
    required this.purposeLegitimateInterests,
    required this.vendorConsents,
    required this.vendorLegitimateInterests,
    required this.specialFeatureOptions,
    required this.publisherConsents,
    required this.publisherLegitimateInterests,
    required this.publisherCustomPurposeConsents,
    required this.publisherCustomPurposeLegitimateInterests,
    required this.publisherRestrictions,
  }) : super(
          raw: raw,
          sdkId: sdkId,
          sdkVersion: sdkVersion,
          policyVersion: policyVersion,
          gdprApplies: gdprApplies,
        );

  /// base64url-encoded TC string with segments.
  final String tcString;

  /// Whether the TC String is service-specific/publisher-specific.
  ///
  /// Returns `false` when using a global TC String.
  final bool isServiceSpecific;

  /// Whether CMP is using publisher-customized stack descriptions.
  final bool useNonStandardStacks;

  /// Country code of the country that determines the legislation of reference.
  ///
  /// Normally corresponds to the country code of the country in which the
  /// publisher's business entity is established.
  final String publisherCC;

  /// Treatment of [DataUsagePurpose.storeAndAccessInformationOnADevice].
  final PurposeOneTreatment purposeOneTreatment;

  /// Allowed [DataUsagePurpose]s, on the basis of consent.
  final List<DataUsagePurpose> purposeConsents;

  /// Allowed [DataUsagePurpose]s, on the basis of legitimate interests.
  final List<DataUsagePurpose> purposeLegitimateInterests;

  /// IDs of allowed vendors, on the basis of consent.
  final List<int> vendorConsents;

  /// IDs of allowed vendors, on the basis of legitimate interests.
  final List<int> vendorLegitimateInterests;

  /// [SpecialFeature]s the user has opted in to.
  final List<SpecialFeature> specialFeatureOptions;

  /// Allowed publisher [DataUsagePurpose]s, on the basis of consent.
  final List<DataUsagePurpose> publisherConsents;

  /// Allowed publisher [DataUsagePurpose]s, on the basis of legitimate 
  /// interests.
  final List<DataUsagePurpose> publisherLegitimateInterests;

  /// Allowed custom publisher [DataUsagePurpose]s, on the basis of consent.
  final List<int> publisherCustomPurposeConsents;

  /// Allowed custom publisher [DataUsagePurpose]s, on the basis of legitimate 
  /// interests.
  final List<int> publisherCustomPurposeLegitimateInterests;

  /// Restriction of Purposes per vendors, by the publisher.
  final Map<DataUsagePurpose, Map<int, VendorRestriction>>
      publisherRestrictions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentInfo &&
          runtimeType == other.runtimeType &&
          super == other &&
          tcString == other.tcString &&
          isServiceSpecific == other.isServiceSpecific &&
          useNonStandardStacks == other.useNonStandardStacks &&
          publisherCC == other.publisherCC &&
          purposeOneTreatment == other.purposeOneTreatment &&
          listEquals(purposeConsents, other.purposeConsents) &&
          listEquals(
              purposeLegitimateInterests, other.purposeLegitimateInterests) &&
          listEquals(vendorConsents, other.vendorConsents) &&
          listEquals(
              vendorLegitimateInterests, other.vendorLegitimateInterests) &&
          listEquals(specialFeatureOptions, other.specialFeatureOptions) &&
          listEquals(publisherConsents, other.publisherConsents) &&
          listEquals(
            publisherLegitimateInterests,
            other.publisherLegitimateInterests,
          ) &&
          listEquals(
            publisherCustomPurposeConsents,
            other.publisherCustomPurposeConsents,
          ) &&
          listEquals(
            publisherCustomPurposeLegitimateInterests,
            other.publisherCustomPurposeLegitimateInterests,
          ) &&
          const DeepCollectionEquality().equals(
            publisherRestrictions,
            other.publisherRestrictions,
          );

  @override
  int get hashCode =>
      super.hashCode ^
      tcString.hashCode ^
      isServiceSpecific.hashCode ^
      useNonStandardStacks.hashCode ^
      publisherCC.hashCode ^
      purposeOneTreatment.hashCode ^
      hashList(purposeConsents) ^
      hashList(purposeLegitimateInterests) ^
      hashList(vendorConsents) ^
      hashList(vendorLegitimateInterests) ^
      hashList(specialFeatureOptions) ^
      hashList(publisherConsents) ^
      hashList(publisherLegitimateInterests) ^
      hashList(publisherCustomPurposeConsents) ^
      hashList(publisherCustomPurposeLegitimateInterests) ^
      const DeepCollectionEquality().hash(publisherRestrictions);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    IterableProperty<String> enumList(String name, Iterable<Object> list) =>
        IterableProperty(name, list.map((e) => describeEnum(e)));

    properties
      ..add(StringProperty('tcString', tcString))
      ..add(DiagnosticsProperty('isServiceSpecific', isServiceSpecific))
      ..add(DiagnosticsProperty('useNonStandardStacks', useNonStandardStacks))
      ..add(StringProperty('publisherCC', publisherCC))
      ..add(EnumProperty('purposeOneTreatment', purposeOneTreatment))
      ..add(enumList('purposeConsents', purposeConsents))
      ..add(enumList('purposeLegitimateInterests', purposeLegitimateInterests))
      ..add(IterableProperty('vendorConsents', vendorConsents))
      ..add(IterableProperty(
        'vendorLegitimateInterests',
        vendorLegitimateInterests,
      ))
      ..add(enumList('specialFeatureOptions', specialFeatureOptions))
      ..add(enumList('publisherConsents', publisherConsents))
      ..add(enumList(
        'publisherLegitimateInterests',
        publisherLegitimateInterests,
      ))
      ..add(IterableProperty(
        'publisherCustomPurposeConsents',
        publisherCustomPurposeConsents,
      ))
      ..add(IterableProperty(
        'publisherCustomPurposeLegitimateInterests',
        publisherCustomPurposeLegitimateInterests,
      ))
      ..add(DiagnosticsProperty(
        'publisherRestrictions',
        publisherRestrictions,
      ));
  }
}

/// Create [BasicConsentInfo] from the raw consent information, which is made
/// available by an CMP SDK.
BasicConsentInfo? parseRawConsentInfo(Map<String, dynamic> raw) {
  final sdkId = raw['IABTCF_CmpSdkID'] as int?;

  // The sdk id should be set as early as possible by the CMP sdk to signal
  // its existence.
  // https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#in-app-details
  if (sdkId == null) {
    return null;
  }

  final sdkVersion = raw['IABTCF_CmpSdkVersion'] as int?;
  final policyVersion = raw['IABTCF_PolicyVersion'] as int?;
  final gdprApplies =
      (raw['IABTCF_gdprApplies'] as int?)?.let(_parseNumberAsBool);
  final tcString = raw['IABTCF_TCString'] as String?;

  if (tcString == null) {
    return BasicConsentInfo(
      raw: raw,
      sdkId: sdkId,
      sdkVersion: sdkVersion,
      policyVersion: policyVersion,
      gdprApplies: gdprApplies,
    );
  }

  return ConsentInfo(
    raw: raw,
    sdkId: sdkId,
    sdkVersion: sdkVersion,
    policyVersion: policyVersion,
    gdprApplies: true,
    tcString: tcString,
    isServiceSpecific: true,
    useNonStandardStacks:
        (raw['IABTCF_UseNonStandardStacks'] as int).let(_parseNumberAsBool),
    publisherCC: raw['IABTCF_PublisherCC'] as String,
    purposeOneTreatment: ((raw['IABTCF_PurposeOneTreatment'] as int?) ?? 0)
        .let(_parsePurposeOneTreatment),
    purposeConsents: (raw['IABTCF_PurposeConsents'] as String?)
        .let(_parseDataUsagePurposeBinaryString),
    purposeLegitimateInterests:
        (raw['IABTCF_PurposeLegitimateInterests'] as String?)
            .let(_parseDataUsagePurposeBinaryString),
    vendorConsents:
        (raw['IABTCF_VendorConsents'] as String?).let(_parseIdBinaryString),
    vendorLegitimateInterests:
        (raw['IABTCF_VendorLegitimateInterests'] as String?)
            .let(_parseIdBinaryString),
    specialFeatureOptions: (raw['IABTCF_SpecialFeaturesOptIns'] as String?)
        .let(_parseSpecialFeatureBinaryString),
    publisherConsents: (raw['IABTCF_PublisherConsent'] as String?)
        .let(_parseDataUsagePurposeBinaryString),
    publisherLegitimateInterests:
        (raw['IABTCF_PublisherLegitimateInterests'] as String?)
            .let(_parseDataUsagePurposeBinaryString),
    publisherCustomPurposeConsents:
        (raw['IABTCF_PublisherCustomPurposesConsents'] as String?)
            .let(_parseIdBinaryString),
    publisherCustomPurposeLegitimateInterests:
        (raw['IABTCF_PublisherCustomPurposesLegitimateInterests'] as String?)
            .let(_parseIdBinaryString),
    publisherRestrictions: _parsePublisherRestriction(raw),
  );
}

/// Parses an [int] as a [bool].
bool _parseNumberAsBool(int value) {
  assert(value == 0 || value == 1);
  return value == 0 ? false : true;
}

PurposeOneTreatment _parsePurposeOneTreatment(int index) =>
    PurposeOneTreatment.values[index];

/// Takes a string of only `0`s and `1`s, and returns the 0-based indices of
/// the `1`s.
Iterable<int> _parseBinaryString(String? string) =>
    string
        ?.split('')
        .asMap()
        .entries
        .where((it) => it.value == '1')
        .map((it) => it.key) ??
    [];

Map<DataUsagePurpose, Map<int, VendorRestriction>> _parsePublisherRestriction(
    Map<String, dynamic> raw) {
  final result = <DataUsagePurpose, Map<int, VendorRestriction>>{};

  for (final purpose in DataUsagePurpose.values) {
    final id = DataUsagePurpose.values.indexOf(purpose) + 1;
    final key = 'IABTCF_PublisherRestrictions$id';
    final restrictions = raw[key] as String?;
    if (restrictions != null) {
      result[purpose] = _parseVendorRestrictionsString(restrictions);
    }
  }

  return result;
}

Map<int, VendorRestriction> _parseVendorRestrictionsString(String string) =>
    string
        .split('')
        .asMap()
        .entries
        .map((entry) => MapEntry(
              entry.key + 1,
              VendorRestriction.values[int.parse(entry.value)],
            ))
        .let((entries) => Map.fromEntries(entries));

List<DataUsagePurpose> _parseDataUsagePurposeBinaryString(String? string) =>
    _parseBinaryString(string)
        .map((it) => DataUsagePurpose.values[it])
        .toList();

List<int> _parseIdBinaryString(String? string) =>
    _parseBinaryString(string).map((index) => index + 1).toList();

List<SpecialFeature> _parseSpecialFeatureBinaryString(String? string) =>
    _parseBinaryString(string).map((it) => SpecialFeature.values[it]).toList();

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
