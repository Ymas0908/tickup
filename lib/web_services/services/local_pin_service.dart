import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickup/web_services/services/pin_crypto_service.dart';


class LocalPinService {
  final _storage = const FlutterSecureStorage();

  static const _pinHashKey = 'pin_hash';
  static const _pinSaltKey = 'pin_salt';

  /// Création du PIN
  Future<void> createPin(String pin) async {
    final salt = PinCryptoService.generateSalt();
    final hash = PinCryptoService.hashPin(pin, salt);

    await _storage.write(key: _pinSaltKey, value: salt);
    await _storage.write(key: _pinHashKey, value: hash);
  }

  /// Vérification
  Future<bool> verifyPin(String pin) async {
    final salt = await _storage.read(key: _pinSaltKey);
    final storedHash = await _storage.read(key: _pinHashKey);

    if (salt == null || storedHash == null) return false;

    final hash = PinCryptoService.hashPin(pin, salt);
    return hash == storedHash;
  }

  /// Existe ?
  Future<bool> hasPin() async {
    return await _storage.read(key: _pinHashKey) != null;
  }

  /// Reset (logout / sécurité)
  Future<void> clearPin() async {
    await _storage.delete(key: _pinHashKey);
    await _storage.delete(key: _pinSaltKey);
  }
}
