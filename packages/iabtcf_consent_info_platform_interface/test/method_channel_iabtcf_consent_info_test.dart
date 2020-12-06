import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iabtcf_consent_info_platform_interface/iabtcf_consent_info_platform_interface.dart';
import 'package:pedantic/pedantic.dart';

const channelName = 'blaugold.github.io/iabtcf_consent_info';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final eventChannel = EventChannel(channelName);
  final methodChannel = MethodChannel(channelName);

  test('startSendingUpdates', () async {
    var channelHasStartedListening = false;
    methodChannel.setMockMethodCallHandler((call) async {
      channelHasStartedListening = call.method == 'listen';
    });

    final firstEvent =
        IabtcfConsentInfoPlatform.instance.startSendingUpdates().first;

    expect(channelHasStartedListening, isTrue);

    var firstResult = {'key': 'value'};

    unawaited(eventChannel.binaryMessenger.handlePlatformMessage(
      channelName,
      eventChannel.codec.encodeSuccessEnvelope(firstResult),
      (data) {},
    ));

    expect(await firstEvent, equals(firstResult));
  });
}
