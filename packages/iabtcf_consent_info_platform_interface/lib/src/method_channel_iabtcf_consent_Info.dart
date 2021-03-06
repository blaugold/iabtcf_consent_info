import 'package:flutter/services.dart';

import '../iabtcf_consent_info_platform_interface.dart';

const _channel = EventChannel('com.terwesten.gabriel/iabtcf_consent_info');

/// Method channel implementation of [IabtcfConsentInfoPlatform].
class MethodChannelIabtcfConsentInfo extends IabtcfConsentInfoPlatform {
  late final _stream = _channel
      .receiveBroadcastStream()
      .map((dynamic info) => (info as Map).cast<String, dynamic>());

  @override
  Stream<Map<String, dynamic>> rawConsentInfo() => _stream;
}
