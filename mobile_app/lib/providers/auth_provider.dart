import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/mock_data_service.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
}

class AuthProvider with ChangeNotifier {
  final MockDataService _mockService = MockDataService();
  
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _error;

  AuthProvider();

  AuthStatus get status => _status;
  User? get user => _user;
  String? get error => _error;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    
    _user = _mockService.currentUser;
    if (_user != null) {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();

    try {
      final success = await _mockService.login(username, password);
      if (success) {
        _user = _mockService.currentUser;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid credentials';
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String passportNumber,
  }) async {
    _status = AuthStatus.loading;
    _error = null;
    notifyListeners();

    try {
      final success = await _mockService.register(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
        passportNumber: passportNumber,
      );
      
      if (success) {
        _user = _mockService.currentUser;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _error = 'Registration failed';
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _mockService.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
