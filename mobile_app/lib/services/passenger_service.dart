import '../models/models.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class PassengerService {
  final ApiService _apiService;

  PassengerService(this._apiService);

  Future<Passenger> getPassengerById(String id) async {
    final response = await _apiService.get('${ApiConstants.passengerEndpoint}/$id');
    return Passenger.fromJson(response);
  }

  Future<Passenger> completeRegistration({
    required String passportNumber,
    required int passengerType,
    required int age,
  }) async {
    final response = await _apiService.post(
      ApiConstants.completeRegistrationEndpoint,
      {
        'passportNumber': passportNumber,
        'passengerType': passengerType,
        'age': age,
      },
    );
    return Passenger.fromJson(response);
  }
}
