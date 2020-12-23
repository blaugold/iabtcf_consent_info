import 'package:flutter/services.dart';

import '../iabtcf_consent_info_platform_interface.dart';

const _channel = EventChannel('com.terwesten.gabriel/iabtcf_consent_info');

/// Method channel implementation of [IabtcfConsentInfoPlatform].
class MethodChannelIabtcfConsentInfo extends IabtcfConsentInfoPlatform {
  @override
  Stream<Map<String, dynamic>> rawConsentInfo() {
    return _channel
        .receiveBroadcastStream()
        .map((info) => (info as Map).cast<String, dynamic>());
  }
}
