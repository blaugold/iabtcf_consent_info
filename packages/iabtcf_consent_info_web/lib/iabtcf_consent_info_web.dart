import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/cmp_api.dart';

/// A web implementation of the IabtcfConsentInfoWeb plugin.
///
/// This plugin implements the platform side of the method channel interface
/// defined in [iabtcf_consent_info_platform_interface].
class IabtcfConsentInfoWeb {
  /// Registers this implementation with the flutter framework.
  static void registerWith(Registrar registrar) {
    final channel = PluginEventChannel<Map<String, dynamic>>(
      'com.terwesten.gabriel/iabtcf_consent_info',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = IabtcfConsentInfoWeb();
    channel.setController(pluginInstance.rawConsentInfoController);
  }

  /// The stream controller, whose stream emits raw consent info.
  late final rawConsentInfoController =
      StreamController<Map<String, dynamic>>.broadcast(
    onListen: _onListen,
    onCancel: _onCancel,
  );

  num? _listenerId = null;

  void _onListen() {
    addEventListener(_listener);
  }

  void _onCancel() {
    removeEventListener((success) {
      if (!success) {
        rawConsentInfoController.addError(PlatformException(
          code: 'unregister-listener-failed',
        ));
      }
    }, _listenerId!);

    _listenerId = null;
  }

  void _listener(TCData? data, bool success) {
    if (!success) {
      rawConsentInfoController.addError(PlatformException(
        code: 'register-listener-failed',
      ));
    } else {
      _listenerId = data!.listenerId;
      rawConsentInfoController.add(data.toInAppTCDataMap());
    }
  }
}
