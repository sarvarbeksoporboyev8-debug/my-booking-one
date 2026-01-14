enum FlightStatus {
  unknown,
  flying,
  delay,
  canceled,
  completed,
}

class Flight {
  final String id;
  final String flightNumber;
  final String aircraftId;
  final String departureAirportId;
  final DateTime departureDate;
  final DateTime arriveDate;
  final String arriveAirportId;
  final double durationMinutes;
  final DateTime flightDate;
  final FlightStatus status;
  final double price;
  
  // Additional display fields
  final String? departureAirportName;
  final String? arriveAirportName;
  final String? aircraftName;

  Flight({
    required this.id,
    required this.flightNumber,
    required this.aircraftId,
    required this.departureAirportId,
    required this.departureDate,
    required this.arriveDate,
    required this.arriveAirportId,
    required this.durationMinutes,
    required this.flightDate,
    required this.status,
    required this.price,
    this.departureAirportName,
    this.arriveAirportName,
    this.aircraftName,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      aircraftId: json['aircraftId'] ?? '',
      departureAirportId: json['departureAirportId'] ?? '',
      departureDate: DateTime.tryParse(json['departureDate'] ?? '') ?? DateTime.now(),
      arriveDate: DateTime.tryParse(json['arriveDate'] ?? '') ?? DateTime.now(),
      arriveAirportId: json['arriveAirportId'] ?? '',
      durationMinutes: (json['durationMinutes'] ?? 0).toDouble(),
      flightDate: DateTime.tryParse(json['flightDate'] ?? '') ?? DateTime.now(),
      status: FlightStatus.values[json['status'] ?? 0],
      price: (json['price'] ?? 0).toDouble(),
      departureAirportName: json['departureAirportName'],
      arriveAirportName: json['arriveAirportName'],
      aircraftName: json['aircraftName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flightNumber': flightNumber,
      'aircraftId': aircraftId,
      'departureAirportId': departureAirportId,
      'departureDate': departureDate.toIso8601String(),
      'arriveDate': arriveDate.toIso8601String(),
      'arriveAirportId': arriveAirportId,
      'durationMinutes': durationMinutes,
      'flightDate': flightDate.toIso8601String(),
      'status': status.index,
      'price': price,
    };
  }

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = (durationMinutes % 60).toInt();
    return '${hours}h ${minutes}m';
  }

  String get statusText {
    switch (status) {
      case FlightStatus.flying:
        return 'In Flight';
      case FlightStatus.delay:
        return 'Delayed';
      case FlightStatus.canceled:
        return 'Canceled';
      case FlightStatus.completed:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
