import '../models/models.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class FlightService {
  final ApiService _apiService;

  FlightService(this._apiService);

  Future<List<Flight>> getAvailableFlights() async {
    final response = await _apiService.get(ApiConstants.availableFlightsEndpoint);
    final List<dynamic> data = response['data'] ?? response['flights'] ?? [];
    return data.map((json) => Flight.fromJson(json)).toList();
  }

  Future<Flight> getFlightById(String id) async {
    final response = await _apiService.get('${ApiConstants.flightsEndpoint}/$id');
    return Flight.fromJson(response);
  }

  Future<List<Seat>> getAvailableSeats(String flightId) async {
    final response = await _apiService.get('${ApiConstants.availableSeatsEndpoint}/$flightId');
    final List<dynamic> data = response['data'] ?? response['seats'] ?? [];
    return data.map((json) => Seat.fromJson(json)).toList();
  }

  Future<void> reserveSeat(String flightId, String seatNumber) async {
    await _apiService.post(
      ApiConstants.reserveSeatEndpoint,
      {
        'flightId': flightId,
        'seatNumber': seatNumber,
      },
    );
  }
}
