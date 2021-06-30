@JS()
library cmp_api;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

/// Transparency and consent data, which is available through the CMP API.
@JS()
@anonymous
class TCData {
  /// Plain JS Object constructor.
  external factory TCData({
    int cmpId,
    int cmpVersion,
    int tcfPolicyVersion,
    String tcString,
    bool? gdprApplies,
    num? listenerId,
    PublisherTCData publisher,
  });

  /// Id of the CMP SDK.
  external int get cmpId;

  /// Version of the CMP SDK.
  external int get cmpVersion;

  /// Version of the TCF policy.
  external int get tcfPolicyVersion;

  /// base64url-encoded TC string with segments.
  external String get tcString;

  /// Whether or not the GDPR applies for the current user, or `null` if
  /// unknown.
  external bool? get gdprApplies;

  /// If this TCData is sent to the callback of addEventListener: number,
  /// the unique ID assigned by the CMP to the listener function registered
  /// via [addEventListener].
  /// Others: undefined.
  external num? get listenerId;

  /// TC data for the publisher.
  external PublisherTCData get publisher;
}

/// Extensions on [TCData].
extension TCDataExt on TCData {
  /// Returns this data as represented in mobile apps.
  Map<String, dynamic> toInAppTCDataMap() {
    return <String, dynamic>{
      'IABTCF_CmpSdkID': cmpId,
      'IABTCF_CmpSdkVersion': cmpVersion,
      'IABTCF_PolicyVersion': tcfPolicyVersion,
      'IABTCF_gdprApplies': gdprApplies?.let(_boolToInt),
      'IABTCF_PublisherConsent': _idToBoolMapToBitString(publisher.consents),
      'IABTCF_PublisherLegitimateInterests':
          _idToBoolMapToBitString(publisher.legitimateInterests),
    };
  }
}

/// Transparency and consent data for the publisher, which is embedding a CMD
/// SDK.
@JS()
@anonymous
class PublisherTCData {
  /// Plain JS Object constructor.
  external factory PublisherTCData({
    Object consents,
    Object legitimateInterests,
  });

  /// Map of purpose ids to bool which signals whether consent has been
  /// obtained.
  external Object get consents;

  /// Map of purpose ids to bool which signals whether legitimate interest has
  /// been established.
  external Object get legitimateInterests;
}

/// Listener which is called when TC data changes.
///
/// [success] signals whether the the listener could be registered.
typedef TCDataListener = void Function(TCData? data, bool success);

@JS('__tcfapi')
external void _addEventListener(
  String command,
  int version,
  TCDataListener listener,
);

/// Registers a callback function with a CMP
///
/// See:
/// - [Spec](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#addeventlistener)
void addEventListener(TCDataListener listener) {
  _addEventListener('addEventListener', 2, allowInterop(listener));
}

/// Callback which is invoked with the result of [removeEventListener].
///
/// [success] signals whether the the listener could be unregistered.
typedef RemoveEventListenerCallback = void Function(bool success);

@JS('__tcfapi')
external void _removeEventListener(
  String command,
  int version,
  RemoveEventListenerCallback callback,
  num listenerId,
);

/// Unregisters a callback function with a CMP.
///
/// See:
/// - [Spec](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#removeeventlistener)
void removeEventListener(RemoveEventListenerCallback callback, num listenerId) {
  _removeEventListener(
    'removeEventListener',
    2,
    allowInterop(callback),
    listenerId,
  );
}

int _boolToInt(bool value) => value ? 1 : 0;

/// Converts a map, whose keys are ids and whose values are bools, to
/// a bit string, where each character corresponds to an id, based on its index,
/// and `true` and `false` are represented by `1` and `0`, respectively.
///
/// The ids in the map start at `1`, while the corresponding bit indices start
/// at `0`.
String _idToBoolMapToBitString(Object map) {
  // Extract entries from plain JS object.
  final entries = _Object_getOwnPropertyNames(map).map((idString) {
    final key = int.parse(idString);
    final value = getProperty(map, idString) as bool;
    return MapEntry(key, value);
  });

  // Find indices of enabled bits.
  final indices = entries
      .where((e) => e.value)
      // Ids start a 1 but bit indices start at 0.
      .map((e) => e.key - 1)
      .toList();

  if (indices.isEmpty) return '';

  // Create bit string
  final maxIndex = indices.reduce((a, b) => a > b ? a : b);
  final bits = List.filled(maxIndex + 1, '0');
  for (var i in indices) {
    bits[i] = '1';
  }
  return bits.join('');
}

@JS('Object.getOwnPropertyNames')
external List<String> _Object_getOwnPropertyNames(Object object);

extension _ValueExt<T> on T {
  /// Apply this value to [fn] and return the result.
  R let<R>(R Function(T) fn) => fn(this);
}
