import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tickup/web_services/services/pin_crypto.dart';

class LocalAuthService {
  static const _pinKey = 'local_pin_hash';
  final _auth = LocalAuthentication();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> authenticate() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate
        ? await _auth.authenticate(
            localizedReason: 'Veuillez vous authentifier',
            biometricOnly: false,
          )
        : false;
  }

  /* ======================================================
   * BIOMÉTRIE
   * ====================================================== */

  Future<bool> authenticateWithBiometrics() async {
    try {
      print("AUTHENTICATE WITH BIOMETRICS");
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      print("CAN CHECK BIOMETRICS: $canCheck");
      print("IS SUPPORTED: $isSupported");

      if (!canCheck || !isSupported) return false;

      return await _auth.authenticate(
        localizedReason: 'Veuillez vous authentifier',
        biometricOnly: false,
      );
    } on PlatformException {
      return false;
    }
  }

  /// Sauvegarde du PIN
  Future<void> savePin(String pin) async {
    final hash = PinCrypto.hashPin(pin);
    await _storage.write(key: _pinKey, value: hash);
  }

  /// Vérification du PIN
  Future<bool> verifyPin(String enteredPin) async {
    final storedHash = await _storage.read(key: _pinKey);
    if (storedHash == null) return false;

    final enteredHash = PinCrypto.hashPin(enteredPin);
    return storedHash == enteredHash;
  }

  /// Vérifie si un PIN existe
  Future<bool> hasPin() async {
    return await _storage.read(key: _pinKey) != null;
  }

  /// Suppression (logout)
  Future<void> clearPin() async {
    await _storage.delete(key: _pinKey);
  }
}
