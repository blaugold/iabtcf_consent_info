import 'package:flutter_test/flutter_test.dart';
import 'package:iabtcf_consent_info/iabtcf_consent_info.dart';
import 'package:integration_test/integration_test.dart';

final testConsentInfo = ConsentInfo(
  raw: <String, dynamic>{},
  sdkId: 0,
  sdkVersion: 0,
  policyVersion: 2,
  gdprApplies: true,
  tcString: 'test',
  isServiceSpecific: true,
  useNonStandardStacks: false,
  publisherCC: 'AA',
  purposeOneTreatment: PurposeOneTreatment.normal,
  purposeConsents: [],
  purposeLegitimateInterests: [],
  vendorConsents: [],
  vendorLegitimateInterests: [],
  specialFeatureOptions: [],
  publisherConsents: [],
  publisherLegitimateInterests: [],
  publisherCustomPurposeConsents: [],
  publisherCustomPurposeLegitimateInterests: [],
  publisherRestrictions: {},
);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('read current consent info', (WidgetTester _) async {
    final info = await IabtcfConsentInfo.instance.currentConsentInfo();

    expect(info, equals(testConsentInfo));
  });
}
