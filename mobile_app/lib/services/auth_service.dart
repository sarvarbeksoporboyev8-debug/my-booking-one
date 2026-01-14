import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<AuthToken> login(String username, String password) async {
    final response = await _apiService.postForm(
      ApiConstants.tokenEndpoint,
      {
        'grant_type': 'password',
        'client_id': ApiConstants.clientId,
        'client_secret': ApiConstants.clientSecret,
        'username': username,
        'password': password,
        'scope': 'flight-api passenger-api booking-api',
      },
    );

    final token = AuthToken.fromJson(response);
    await _saveToken(token.accessToken);
    _apiService.setAccessToken(token.accessToken);
    return token;
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String passportNumber,
  }) async {
    await _apiService.post(
      ApiConstants.registerEndpoint,
      {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': password,
        'passportNumber': passportNumber,
      },
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userKey);
    _apiService.setAccessToken(null);
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    if (token != null) {
      _apiService.setAccessToken(token);
    }
    return token;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userKey, jsonEncode(user.toJson()));
  }

  Future<User?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(AppConstants.userKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }
}
