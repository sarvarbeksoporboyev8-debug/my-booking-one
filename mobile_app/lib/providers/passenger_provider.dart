import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/mock_data_service.dart';

class PassengerProvider with ChangeNotifier {
  final MockDataService _mockService = MockDataService();

  Passenger? _currentPassenger;
  bool _isLoading = false;
  String? _error;
  bool _isRegistrationComplete = false;

  PassengerProvider();

  Passenger? get currentPassenger => _currentPassenger;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isRegistrationComplete => _isRegistrationComplete;

  void checkRegistration() {
    _currentPassenger = _mockService.currentPassenger;
    _isRegistrationComplete = _currentPassenger != null;
    notifyListeners();
  }

  Future<bool> completeRegistration({
    required String passportNumber,
    required int passengerType,
    required int age,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentPassenger = await _mockService.completeRegistration(
        passportNumber: passportNumber,
        passengerType: passengerType,
        age: age,
      );
      _isRegistrationComplete = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void reset() {
    _currentPassenger = null;
    _isRegistrationComplete = false;
    _error = null;
    notifyListeners();
  }
}
