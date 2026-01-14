import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/services.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService;

  List<Booking> _bookings = [];
  Booking? _currentBooking;
  bool _isLoading = false;
  String? _error;

  BookingProvider(this._bookingService);

  List<Booking> get bookings => _bookings;
  Booking? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bookings = await _bookingService.getBookings();
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
      final request = CreateBookingRequest(
        passengerId: passengerId,
        flightId: flightId,
        description: description,
      );
      _currentBooking = await _bookingService.createBooking(request);
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

  Future<void> loadBookingDetails(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentBooking = await _bookingService.getBookingById(id);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
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
