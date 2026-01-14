import '../models/models.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class BookingService {
  final ApiService _apiService;

  BookingService(this._apiService);

  Future<Booking> createBooking(CreateBookingRequest request) async {
    final response = await _apiService.post(
      ApiConstants.bookingEndpoint,
      request.toJson(),
    );
    return Booking.fromJson(response);
  }

  Future<List<Booking>> getBookings() async {
    final response = await _apiService.get(ApiConstants.bookingEndpoint);
    final List<dynamic> data = response['data'] ?? response['bookings'] ?? [];
    return data.map((json) => Booking.fromJson(json)).toList();
  }

  Future<Booking> getBookingById(String id) async {
    final response = await _apiService.get('${ApiConstants.bookingEndpoint}/$id');
    return Booking.fromJson(response);
  }
}
