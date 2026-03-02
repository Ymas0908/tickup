import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickup/models/enum/session_state.dart';
import 'package:tickup/ressources/utils/log_config.dart';

import '../web_services/services/local_auth_service.dart';
import '../web_services/services/local_pin_service.dart';



class SessionManagerViewModel extends ChangeNotifier {
  SessionState _state = SessionState.splash;
  late final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _localAuthEnabled = false;

  SessionState get state => _state;
  bool _dialogShown = false;

  bool get shouldShowExpiredDialog =>
      _state == SessionState.expired && !_dialogShown;

  bool get isLocalAuthEnabled => _localAuthEnabled;
  static const int maxPinAttempts = 5;

  int _pinAttempts = 0;

  bool get isPinLocked => _pinAttempts >= maxPinAttempts;
  Timer? _inactivityTimer;

  //Durée d'inactivité avant lock
  static const Duration autoLockDuration = Duration(minutes: 5);

  void authenticated() {
    _state = SessionState.authenticated;
    customLogger.i("AUTHENTICATED :::::");
    notifyListeners();
  }

  Future<void> expired() async {
    _state = SessionState.expired;
    await _storage.delete(key: 'auth_token');
    customLogger.i("LE TOKEN A ETE SUPPRIME ::::: ");
    _cancelInactivityTimer();
    notifyListeners();
  }

  void firstConnection() {
    _state = SessionState.firstConnection;
    notifyListeners();
  }

  void splash() {
    _state = SessionState.splash;
    notifyListeners();
  }

  void markDialogShown() {
    _dialogShown = true;
    notifyListeners();
  }

  void forceLogout() {
    _state = SessionState.unauthenticated;
    notifyListeners();
  }

  void logout() {
    customLogger.i("LOGOUT :::::");
    _state = SessionState.unauthenticated;
    _dialogShown = false;
    _storage.deleteAll();
    customLogger.i("LE TOKEN A ETE SUPPRIME :::::");
    customLogger.i("NEW SESSION STATE  ::::: $_state");
    _cancelInactivityTimer();
    notifyListeners();
  }

  /// INIT (au lancement)
  Future<void> init() async {
    final token = await _storage.read(key: 'auth_token');
    final localAuth = await _storage.read(key: 'local_auth_enabled');
    final hasPin = await LocalAuthService().hasPin();
    _localAuthEnabled = localAuth == 'true';

    if (token == null) {
      _state = SessionState.splash;
    } else if (_localAuthEnabled && hasPin) {
      _state = SessionState.locked;
    } else {
      _state = SessionState.authenticated;
    }
    notifyListeners();
  }

  /// ============================
  /// LOCAL AUTH OK
  void unlockLocalAuth() {
    _state = SessionState.authenticated;
    _startInactivityTimer();
    notifyListeners();
  }

  /// ACTIVER AUTH LOCALE
  Future<void> enableLocalAuth() async {
    await _storage.write(key: 'local_auth_enabled', value: 'true');
    _localAuthEnabled = true;
  }

  /// Vérification PIN
  Future<bool> unlockWithPin(String pin) async {
    if (isPinLocked) return false;

    final success = await LocalPinService().verifyPin(pin);

    if (success) {
      _pinAttempts = 0;
      unlockLocalAuth();
      return true;
    } else {
      _pinAttempts++;
      notifyListeners();
      return false;
    }
  }

  void setupPin() {
    _state = SessionState.setupPin;
    notifyListeners();
  }

  /// Reset tentatives (logout)
  void resetPinAttempts() {
    _pinAttempts = 0;
  }

  void error() {
    _state = SessionState.error;
    _dialogShown = false;
    notifyListeners();
  }

  void lock() {
    _state = SessionState.locked;
    _cancelInactivityTimer();
    notifyListeners();
  }

  // INACTIVITY TIMER
  void _startInactivityTimer() {
    _cancelInactivityTimer();
    _inactivityTimer = Timer(autoLockDuration, () {
      lock();
    });
  }

  void _cancelInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  // RESET TIMER (user activity)
  void onUserInteraction() {
    if (_state == SessionState.authenticated) {
      _startInactivityTimer();
    }
  }
}
