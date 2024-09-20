import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String? _token;
  bool _isLoggedIn = false;
  String? _userType;
  String? _email;
  String? _fullName;

  AuthProvider() {
    _loadToken();
  }

  String? get token => _token;
  bool get isLoggedIn => _isLoggedIn;
  String? get userType => _userType;
  String? get email => _email;
  String? get fullName => _fullName;

  Future<void> _loadToken() async {
    _token = await _storage.read(key: 'token');
    _isLoggedIn = _token != null;
    _userType = await _storage.read(key: 'role');
    _email = await _storage.read(key: 'email');
    _fullName = await _storage.read(key: 'fullName');
    notifyListeners();
  }

  Future<void> setToken(
      String? token, String? userType, String? email, String? fullName) async {
    _token = token;
    _isLoggedIn = token != null;
    _userType = userType;
    _email = email;
    _fullName = fullName;

    await _storage.write(key: 'token', value: token ?? '');
    await _storage.write(key: 'role', value: userType ?? '');
    await _storage.write(key: 'email', value: email ?? '');
    await _storage.write(key: 'fullName', value: fullName ?? '');

    notifyListeners();
  }

  Future<void> clear() async {
    await _storage.deleteAll();
    _token = null;
    _isLoggedIn = false;
    _userType = null;
    _email = null;
    _fullName = null;
    notifyListeners();
  }
}
