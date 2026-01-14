import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/services.dart';

class PassengerProvider with ChangeNotifier {
  final PassengerService _passengerService;

  Passenger? _currentPassenger;
  bool _isLoading = false;
  String? _error;
  bool _isRegistrationComplete = false;

  PassengerProvider(this._passengerService);

  Passenger? get currentPassenger => _currentPassenger;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isRegistrationComplete => _isRegistrationComplete;

  Future<void> loadPassenger(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentPassenger = await _passengerService.getPassengerById(id);
      _isRegistrationComplete = true;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
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
      _currentPassenger = await _passengerService.completeRegistration(
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
