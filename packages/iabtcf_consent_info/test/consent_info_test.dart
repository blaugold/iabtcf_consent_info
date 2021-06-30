import 'package:flutter_test/flutter_test.dart';
import 'package:iabtcf_consent_info/iabtcf_consent_info.dart';

void main() {
  test('returns null if IABTCF_CmpSdkID does not exist', () {
    expect(null, parseRawConsentInfo(<String, dynamic>{}));
  });

  test('returns BasicConsentInfo if IABTCF_CmpSdkID exists', () {
    expect(
      BasicConsentInfo(
        raw: <String, dynamic>{},
        sdkId: 0,
        sdkVersion: null,
        policyVersion: null,
        gdprApplies: null,
      ),
      parseRawConsentInfo(<String, dynamic>{
        'IABTCF_CmpSdkID': 0,
      }),
    );

    expect(
      BasicConsentInfo(
        raw: <String, dynamic>{},
        sdkId: 0,
        sdkVersion: 0,
        policyVersion: 0,
        gdprApplies: false,
      ),
      parseRawConsentInfo(<String, dynamic>{
        'IABTCF_CmpSdkID': 0,
        'IABTCF_CmpSdkVersion': 0,
        'IABTCF_PolicyVersion': 0,
        'IABTCF_gdprApplies': 0,
      }),
    );
  });

  test('parses IABTCF_TCString', () {
    expect(
      testConsentInfo(tcString: 'a'),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_TCString': 'a'}),
    );
  });

  test('parses IABTCF_UseNonStandardStacks', () {
    expect(
      testConsentInfo(useNonStandardStacks: false),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_UseNonStandardStacks': 0}),
    );
    expect(
      testConsentInfo(useNonStandardStacks: true),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_UseNonStandardStacks': 1}),
    );
  });

  test('parses IABTCF_PublisherCC', () {
    expect(
      testConsentInfo(publisherCC: 'x'),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_PublisherCC': 'x'}),
    );
  });

  test('parses IABTCF_PurposeOneTreatment', () {
    expect(
      testConsentInfo(purposeOneTreatment: PurposeOneTreatment.special),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_PurposeOneTreatment': 1}),
    );
  });

  test('parses IABTCF_PurposeConsents', () {
    expect(
      testConsentInfo(purposeConsents: [DataUsagePurpose.selectBasicAds]),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_PurposeConsents': '01'}),
    );
  });

  test('parses IABTCF_PurposeLegitimateInterests', () {
    expect(
      testConsentInfo(
        purposeLegitimateInterests: [DataUsagePurpose.selectBasicAds],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PurposeLegitimateInterests': '01',
      }),
    );
  });

  test('parses IABTCF_VendorConsents', () {
    expect(
      testConsentInfo(vendorConsents: [2]),
      parseTestConsentInfo(<String, dynamic>{'IABTCF_VendorConsents': '01'}),
    );
  });

  test('parses IABTCF_VendorLegitimateInterests', () {
    expect(
      testConsentInfo(vendorLegitimateInterests: [2]),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_VendorLegitimateInterests': '01',
      }),
    );
  });

  test('parses IABTCF_SpecialFeaturesOptIns', () {
    expect(
      testConsentInfo(
        specialFeatureOptions: [
          SpecialFeature.activelyScanDeviceCharacteristics,
        ],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_SpecialFeaturesOptIns': '01',
      }),
    );
  });

  test('parses IABTCF_PublisherConsent', () {
    expect(
      testConsentInfo(
        publisherConsents: [DataUsagePurpose.selectBasicAds],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PublisherConsent': '01',
      }),
    );
  });

  test('parses IABTCF_PublisherLegitimateInterests', () {
    expect(
      testConsentInfo(
        publisherLegitimateInterests: [DataUsagePurpose.selectBasicAds],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PublisherLegitimateInterests': '01',
      }),
    );
  });

  test('parses IABTCF_PublisherCustomPurposesConsents', () {
    expect(
      testConsentInfo(
        publisherCustomPurposeConsents: [2],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PublisherCustomPurposesConsents': '01',
      }),
    );
  });

  test('parses IABTCF_PublisherCustomPurposesLegitimateInterests', () {
    expect(
      testConsentInfo(
        publisherCustomPurposeLegitimateInterests: [2],
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PublisherCustomPurposesLegitimateInterests': '01',
      }),
    );
  });

  test('parses IABTCF_PublisherRestrictions{ID}', () {
    expect(
      testConsentInfo(
        publisherRestrictions: {
          DataUsagePurpose.storeAndAccessInformationOnADevice: {
            1: VendorRestriction.notAllowed,
            2: VendorRestriction.requireConsent,
            3: VendorRestriction.requireLegitimateInterest,
          }
        },
      ),
      parseTestConsentInfo(<String, dynamic>{
        'IABTCF_PublisherRestrictions1': '012',
      }),
    );
  });

  test('equality', () {
    expect(testConsentInfo(), testConsentInfo());

    expect(testConsentInfo(sdkId: 0), testConsentInfo(sdkId: 0));
    expect(testConsentInfo(sdkId: 0), isNot(testConsentInfo(sdkId: 1)));

    expect(testConsentInfo(sdkVersion: 0), testConsentInfo(sdkVersion: 0));
    expect(
      testConsentInfo(sdkVersion: 0),
      isNot(testConsentInfo(sdkVersion: 1)),
    );

    expect(
      testConsentInfo(policyVersion: 0),
      testConsentInfo(policyVersion: 0),
    );
    expect(
      testConsentInfo(policyVersion: 0),
      isNot(testConsentInfo(policyVersion: 1)),
    );

    expect(
      testConsentInfo(gdprApplies: true),
      testConsentInfo(gdprApplies: true),
    );
    expect(
      testConsentInfo(gdprApplies: true),
      isNot(testConsentInfo(gdprApplies: false)),
    );

    expect(
      testConsentInfo(tcString: 'a'),
      testConsentInfo(tcString: 'a'),
    );
    expect(
      testConsentInfo(tcString: 'a'),
      isNot(testConsentInfo(tcString: 'b')),
    );

    expect(
      testConsentInfo(isServiceSpecific: true),
      testConsentInfo(isServiceSpecific: true),
    );
    expect(
      testConsentInfo(isServiceSpecific: true),
      isNot(testConsentInfo(isServiceSpecific: false)),
    );

    expect(
      testConsentInfo(useNonStandardStacks: true),
      testConsentInfo(useNonStandardStacks: true),
    );
    expect(
      testConsentInfo(useNonStandardStacks: true),
      isNot(testConsentInfo(useNonStandardStacks: false)),
    );

    expect(
      testConsentInfo(publisherCC: 'a'),
      testConsentInfo(publisherCC: 'a'),
    );
    expect(
      testConsentInfo(publisherCC: 'a'),
      isNot(testConsentInfo(publisherCC: 'b')),
    );

    expect(
      testConsentInfo(purposeOneTreatment: PurposeOneTreatment.normal),
      testConsentInfo(purposeOneTreatment: PurposeOneTreatment.normal),
    );
    expect(
      testConsentInfo(purposeOneTreatment: PurposeOneTreatment.normal),
      isNot(testConsentInfo(purposeOneTreatment: PurposeOneTreatment.special)),
    );

    expect(
      testConsentInfo(purposeConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice,
      ]),
      testConsentInfo(purposeConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice,
      ]),
    );
    expect(
      testConsentInfo(purposeConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice,
      ]),
      isNot(testConsentInfo(purposeConsents: [])),
    );

    expect(
      testConsentInfo(purposeLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      testConsentInfo(purposeLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
    );
    expect(
      testConsentInfo(purposeLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      isNot(testConsentInfo(purposeLegitimateInterests: [])),
    );

    expect(
      testConsentInfo(vendorConsents: [1]),
      testConsentInfo(vendorConsents: [1]),
    );
    expect(
      testConsentInfo(vendorConsents: [1]),
      isNot(testConsentInfo(vendorConsents: [])),
    );

    expect(
      testConsentInfo(vendorLegitimateInterests: [1]),
      testConsentInfo(vendorLegitimateInterests: [1]),
    );
    expect(
      testConsentInfo(vendorLegitimateInterests: [1]),
      isNot(testConsentInfo(vendorLegitimateInterests: [])),
    );

    expect(
      testConsentInfo(specialFeatureOptions: [
        SpecialFeature.activelyScanDeviceCharacteristics
      ]),
      testConsentInfo(specialFeatureOptions: [
        SpecialFeature.activelyScanDeviceCharacteristics
      ]),
    );
    expect(
      testConsentInfo(specialFeatureOptions: [
        SpecialFeature.activelyScanDeviceCharacteristics
      ]),
      isNot(testConsentInfo(specialFeatureOptions: [])),
    );

    expect(
      testConsentInfo(publisherConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      testConsentInfo(publisherConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
    );
    expect(
      testConsentInfo(publisherConsents: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      isNot(testConsentInfo(publisherConsents: [])),
    );

    expect(
      testConsentInfo(publisherLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      testConsentInfo(publisherLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
    );
    expect(
      testConsentInfo(publisherLegitimateInterests: [
        DataUsagePurpose.storeAndAccessInformationOnADevice
      ]),
      isNot(testConsentInfo(publisherLegitimateInterests: [])),
    );

    expect(
      testConsentInfo(publisherCustomPurposeConsents: [1]),
      testConsentInfo(publisherCustomPurposeConsents: [1]),
    );
    expect(
      testConsentInfo(publisherCustomPurposeConsents: [1]),
      isNot(testConsentInfo(publisherCustomPurposeConsents: [])),
    );

    expect(
      testConsentInfo(publisherCustomPurposeLegitimateInterests: [1]),
      testConsentInfo(publisherCustomPurposeLegitimateInterests: [1]),
    );
    expect(
      testConsentInfo(publisherCustomPurposeLegitimateInterests: [1]),
      isNot(testConsentInfo(publisherCustomPurposeLegitimateInterests: [])),
    );

    expect(
      testConsentInfo(publisherRestrictions: {
        DataUsagePurpose.selectBasicAds: {1: VendorRestriction.notAllowed}
      }),
      testConsentInfo(publisherRestrictions: {
        DataUsagePurpose.selectBasicAds: {1: VendorRestriction.notAllowed}
      }),
    );
    expect(
      testConsentInfo(publisherRestrictions: {
        DataUsagePurpose.selectBasicAds: {1: VendorRestriction.notAllowed}
      }),
      isNot(testConsentInfo(publisherRestrictions: {
        DataUsagePurpose.selectBasicAds: {
          1: VendorRestriction.requireLegitimateInterest
        }
      })),
    );
  });
}

ConsentInfo testConsentInfo({
  int? sdkId,
  int? sdkVersion,
  int? policyVersion,
  bool? gdprApplies,
  String? tcString,
  bool? isServiceSpecific,
  bool? useNonStandardStacks,
  String? publisherCC,
  PurposeOneTreatment? purposeOneTreatment,
  List<DataUsagePurpose>? purposeConsents,
  List<DataUsagePurpose>? purposeLegitimateInterests,
  List<int>? vendorConsents,
  List<int>? vendorLegitimateInterests,
  List<SpecialFeature>? specialFeatureOptions,
  List<DataUsagePurpose>? publisherConsents,
  List<DataUsagePurpose>? publisherLegitimateInterests,
  List<int>? publisherCustomPurposeConsents,
  List<int>? publisherCustomPurposeLegitimateInterests,
  Map<DataUsagePurpose, Map<int, VendorRestriction>>? publisherRestrictions,
}) {
  return ConsentInfo(
    raw: <String, dynamic>{},
    sdkId: sdkId ?? 0,
    sdkVersion: sdkVersion ?? 0,
    policyVersion: policyVersion ?? 0,
    gdprApplies: gdprApplies ?? true,
    tcString: tcString ?? 'test',
    isServiceSpecific: isServiceSpecific ?? true,
    useNonStandardStacks: useNonStandardStacks ?? false,
    publisherCC: publisherCC ?? 'AA',
    purposeOneTreatment: purposeOneTreatment ?? PurposeOneTreatment.normal,
    purposeConsents: purposeConsents ?? [],
    purposeLegitimateInterests: purposeLegitimateInterests ?? [],
    vendorConsents: vendorConsents ?? [],
    vendorLegitimateInterests: vendorLegitimateInterests ?? [],
    specialFeatureOptions: specialFeatureOptions ?? [],
    publisherConsents: publisherConsents ?? [],
    publisherLegitimateInterests: publisherLegitimateInterests ?? [],
    publisherCustomPurposeConsents: publisherCustomPurposeConsents ?? [],
    publisherCustomPurposeLegitimateInterests:
        publisherCustomPurposeLegitimateInterests ?? [],
    publisherRestrictions: publisherRestrictions ?? {},
  );
}

Map<String, dynamic> rawTestConsentInfo([Map<String, dynamic>? info]) =>
    <String, dynamic>{
      'IABTCF_CmpSdkID': 0,
      'IABTCF_CmpSdkVersion': 0,
      'IABTCF_PolicyVersion': 0,
      'IABTCF_gdprApplies': 0,
      'IABTCF_TCString': 'test',
      'IABTCF_UseNonStandardStacks': 0,
      'IABTCF_PublisherCC': 'AA',
      if (info != null) ...info,
    };

BasicConsentInfo? parseTestConsentInfo([Map<String, dynamic>? info]) {
  return parseRawConsentInfo(rawTestConsentInfo(info));
}
