import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iabtcf_consent_info_platform_interface/iabtcf_consent_info_platform_interface.dart';
import 'package:pedantic/pedantic.dart';

const channelName = 'com.terwesten.gabriel/iabtcf_consent_info';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final eventChannel = EventChannel(channelName);
  final methodChannel = MethodChannel(channelName);

  testWidgets('startSendingUpdates', (tester) async {
    var channelHasStartedListening = false;
    tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(methodChannel, (call) async {
      channelHasStartedListening = call.method == 'listen';
      return null;
    });

    final firstEvent =
        IabtcfConsentInfoPlatform.instance.rawConsentInfo().first;

    expect(channelHasStartedListening, isTrue);

    var firstResult = {'key': 'value'};

    unawaited(tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      channelName,
      eventChannel.codec.encodeSuccessEnvelope(firstResult),
      (data) {},
    ));

    expect(await firstEvent, equals(firstResult));
  });
}
