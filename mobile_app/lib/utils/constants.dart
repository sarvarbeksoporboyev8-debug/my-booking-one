class ApiConstants {
  // Change this to your actual API gateway URL
  static const String baseUrl = 'https://localhost:5000';
  
  // Identity endpoints
  static const String tokenEndpoint = '/identity/connect/token';
  static const String registerEndpoint = '/identity/api/v1/identity/register-user';
  
  // Flight endpoints
  static const String flightsEndpoint = '/flight/api/v1/flight';
  static const String availableFlightsEndpoint = '/flight/api/v1/flight/get-available-flights';
  static const String availableSeatsEndpoint = '/flight/api/v1/flight/get-available-seats';
  static const String reserveSeatEndpoint = '/flight/api/v1/flight/reserve-seat';
  
  // Passenger endpoints
  static const String passengerEndpoint = '/passenger/api/v1/passenger';
  static const String completeRegistrationEndpoint = '/passenger/api/v1/passenger/complete-registration';
  
  // Booking endpoints
  static const String bookingEndpoint = '/booking/api/v1/booking';
  
  // OAuth client credentials
  static const String clientId = 'client';
  static const String clientSecret = 'secret';
}

class AppConstants {
  static const String appName = 'Flight Booking';
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';
}
