import '../models/models.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  // Mock user for authentication
  User? _currentUser;
  Passenger? _currentPassenger;
  final List<Booking> _bookings = [];

  // Sample flights data
  final List<Flight> _flights = [
    Flight(
      id: 'f1a2b3c4-d5e6-7890-abcd-ef1234567890',
      flightNumber: 'BA-2847',
      aircraftId: 'aircraft-001',
      departureAirportId: 'airport-001',
      departureDate: DateTime.now().add(const Duration(days: 3, hours: 8)),
      arriveDate: DateTime.now().add(const Duration(days: 3, hours: 12, minutes: 30)),
      arriveAirportId: 'airport-002',
      durationMinutes: 270,
      flightDate: DateTime.now().add(const Duration(days: 3)),
      status: FlightStatus.flying,
      price: 450,
      departureAirportName: 'New York (JFK)',
      arriveAirportName: 'London (LHR)',
      aircraftName: 'Boeing 777',
    ),
    Flight(
      id: 'f2b3c4d5-e6f7-8901-bcde-f12345678901',
      flightNumber: 'UA-1052',
      aircraftId: 'aircraft-002',
      departureAirportId: 'airport-003',
      departureDate: DateTime.now().add(const Duration(days: 5, hours: 14)),
      arriveDate: DateTime.now().add(const Duration(days: 5, hours: 17, minutes: 45)),
      arriveAirportId: 'airport-004',
      durationMinutes: 225,
      flightDate: DateTime.now().add(const Duration(days: 5)),
      status: FlightStatus.flying,
      price: 320,
      departureAirportName: 'Los Angeles (LAX)',
      arriveAirportName: 'Chicago (ORD)',
      aircraftName: 'Airbus A320',
    ),
    Flight(
      id: 'f3c4d5e6-f7g8-9012-cdef-123456789012',
      flightNumber: 'EK-215',
      aircraftId: 'aircraft-003',
      departureAirportId: 'airport-005',
      departureDate: DateTime.now().add(const Duration(days: 7, hours: 22)),
      arriveDate: DateTime.now().add(const Duration(days: 8, hours: 6, minutes: 15)),
      arriveAirportId: 'airport-006',
      durationMinutes: 495,
      flightDate: DateTime.now().add(const Duration(days: 7)),
      status: FlightStatus.flying,
      price: 890,
      departureAirportName: 'Dubai (DXB)',
      arriveAirportName: 'Tokyo (NRT)',
      aircraftName: 'Airbus A380',
    ),
    Flight(
      id: 'f4d5e6f7-g8h9-0123-defg-234567890123',
      flightNumber: 'LH-456',
      aircraftId: 'aircraft-004',
      departureAirportId: 'airport-007',
      departureDate: DateTime.now().add(const Duration(days: 2, hours: 6)),
      arriveDate: DateTime.now().add(const Duration(days: 2, hours: 8, minutes: 20)),
      arriveAirportId: 'airport-008',
      durationMinutes: 140,
      flightDate: DateTime.now().add(const Duration(days: 2)),
      status: FlightStatus.flying,
      price: 180,
      departureAirportName: 'Frankfurt (FRA)',
      arriveAirportName: 'Paris (CDG)',
      aircraftName: 'Airbus A319',
    ),
    Flight(
      id: 'f5e6f7g8-h9i0-1234-efgh-345678901234',
      flightNumber: 'SQ-321',
      aircraftId: 'aircraft-005',
      departureAirportId: 'airport-009',
      departureDate: DateTime.now().add(const Duration(days: 10, hours: 1)),
      arriveDate: DateTime.now().add(const Duration(days: 10, hours: 14, minutes: 30)),
      arriveAirportId: 'airport-010',
      durationMinutes: 810,
      flightDate: DateTime.now().add(const Duration(days: 10)),
      status: FlightStatus.flying,
      price: 1250,
      departureAirportName: 'Singapore (SIN)',
      arriveAirportName: 'San Francisco (SFO)',
      aircraftName: 'Boeing 787',
    ),
    Flight(
      id: 'f6f7g8h9-i0j1-2345-fghi-456789012345',
      flightNumber: 'QF-008',
      aircraftId: 'aircraft-006',
      departureAirportId: 'airport-011',
      departureDate: DateTime.now().add(const Duration(days: 4, hours: 19)),
      arriveDate: DateTime.now().add(const Duration(days: 5, hours: 6, minutes: 45)),
      arriveAirportId: 'airport-012',
      durationMinutes: 705,
      flightDate: DateTime.now().add(const Duration(days: 4)),
      status: FlightStatus.delay,
      price: 980,
      departureAirportName: 'Sydney (SYD)',
      arriveAirportName: 'Dallas (DFW)',
      aircraftName: 'Boeing 787-9',
    ),
  ];

  // Generate seats for a flight
  List<Seat> _generateSeatsForFlight(String flightId) {
    final seats = <Seat>[];
    final rows = ['A', 'B', 'C', 'D', 'E', 'F'];
    
    for (int i = 1; i <= 10; i++) {
      for (int j = 0; j < rows.length; j++) {
        final seatNumber = '${i}${rows[j]}';
        SeatType type;
        if (j == 0 || j == 5) {
          type = SeatType.window;
        } else if (j == 2 || j == 3) {
          type = SeatType.aisle;
        } else {
          type = SeatType.middle;
        }
        
        SeatClass seatClass;
        if (i <= 2) {
          seatClass = SeatClass.firstClass;
        } else if (i <= 4) {
          seatClass = SeatClass.business;
        } else {
          seatClass = SeatClass.economy;
        }

        seats.add(Seat(
          id: 'seat-$flightId-$seatNumber',
          seatNumber: seatNumber,
          type: type,
          seatClass: seatClass,
          flightId: flightId,
          isReserved: false,
        ));
      }
    }
    return seats;
  }

  // Auth methods
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Accept any non-empty credentials for demo
    if (username.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: 'user-001',
        firstName: 'Demo',
        lastName: 'User',
        username: username,
        email: '$username@demo.com',
        passportNumber: 'DEMO123456',
      );
      return true;
    }
    return false;
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String passportNumber,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    _currentUser = User(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      passportNumber: passportNumber,
    );
    return true;
  }

  User? get currentUser => _currentUser;

  void logout() {
    _currentUser = null;
    _currentPassenger = null;
  }

  // Flight methods
  Future<List<Flight>> getAvailableFlights() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _flights;
  }

  Future<Flight?> getFlightById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _flights.firstWhere((f) => f.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Seat>> getAvailableSeats(String flightId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _generateSeatsForFlight(flightId);
  }

  // Passenger methods
  Future<Passenger> completeRegistration({
    required String passportNumber,
    required int passengerType,
    required int age,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentPassenger = Passenger(
      id: 'passenger-${DateTime.now().millisecondsSinceEpoch}',
      name: '${_currentUser?.firstName ?? "Demo"} ${_currentUser?.lastName ?? "User"}',
      passportNumber: passportNumber,
      passengerType: PassengerType.values[passengerType],
      age: age,
    );
    return _currentPassenger!;
  }

  Passenger? get currentPassenger => _currentPassenger;

  // Booking methods
  Future<Booking> createBooking({
    required String passengerId,
    required String flightId,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final flight = _flights.firstWhere((f) => f.id == flightId);
    
    final booking = Booking(
      id: 'booking-${DateTime.now().millisecondsSinceEpoch}',
      passengerId: passengerId,
      flightId: flightId,
      description: description,
      createdAt: DateTime.now(),
      passengerName: _currentPassenger?.name ?? 'Demo User',
      flightNumber: flight.flightNumber,
    );
    
    _bookings.add(booking);
    return booking;
  }

  Future<List<Booking>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _bookings;
  }
}
