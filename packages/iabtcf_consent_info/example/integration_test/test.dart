import 'package:flutter_test/flutter_test.dart';
import 'package:iabtcf_consent_info/iabtcf_consent_info.dart';
import 'package:integration_test/integration_test.dart';

final testDataUsagePurposes =
    [1, 3, 5, 7, 9].map((i) => DataUsagePurpose.values[i]).toList();

final testConsentInfo = ConsentInfo(
  sdkId: 0,
  sdkVersion: 0,
  policyVersion: 2,
  gdprApplies: true,
  publisherConsent: testDataUsagePurposes,
  publisherLegitimateInterests: testDataUsagePurposes,
);

void main() => run(_testMain);

void _testMain() {
  testWidgets('read current consent info', (WidgetTester _) async {
    final info = await IabtcfConsentInfo.instance.currentConsentInfo();

    expect(info, equals(testConsentInfo));
  });
}
