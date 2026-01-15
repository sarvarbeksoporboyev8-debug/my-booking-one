import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/mock_data_service.dart';

class BookingProvider with ChangeNotifier {
  final MockDataService _mockService = MockDataService();

  List<Booking> _bookings = [];
  Booking? _currentBooking;
  bool _isLoading = false;
  String? _error;

  BookingProvider();

  List<Booking> get bookings => _bookings;
  Booking? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bookings = await _mockService.getBookings();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createBooking({
    required String passengerId,
    required String flightId,
    required String description,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentBooking = await _mockService.createBooking(
        passengerId: passengerId,
        flightId: flightId,
        description: description,
      );
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

  void clearCurrentBooking() {
    _currentBooking = null;
    notifyListeners();
  }
}
