import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/services.dart';

class FlightProvider with ChangeNotifier {
  final FlightService _flightService;

  List<Flight> _flights = [];
  List<Seat> _availableSeats = [];
  Flight? _selectedFlight;
  Seat? _selectedSeat;
  bool _isLoading = false;
  String? _error;

  FlightProvider(this._flightService);

  List<Flight> get flights => _flights;
  List<Seat> get availableSeats => _availableSeats;
  Flight? get selectedFlight => _selectedFlight;
  Seat? get selectedSeat => _selectedSeat;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAvailableFlights() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _flights = await _flightService.getAvailableFlights();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadFlightDetails(String flightId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedFlight = await _flightService.getFlightById(flightId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadAvailableSeats(String flightId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _availableSeats = await _flightService.getAvailableSeats(flightId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectFlight(Flight flight) {
    _selectedFlight = flight;
    _selectedSeat = null;
    notifyListeners();
  }

  void selectSeat(Seat seat) {
    _selectedSeat = seat;
    notifyListeners();
  }

  Future<bool> reserveSeat(String flightId, String seatNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _flightService.reserveSeat(flightId, seatNumber);
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

  void clearSelection() {
    _selectedFlight = null;
    _selectedSeat = null;
    _availableSeats = [];
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
