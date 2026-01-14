class Booking {
  final String id;
  final String passengerId;
  final String flightId;
  final String? seatNumber;
  final String description;
  final DateTime? createdAt;
  
  // Expanded details for display
  final String? passengerName;
  final String? flightNumber;

  Booking({
    required this.id,
    required this.passengerId,
    required this.flightId,
    this.seatNumber,
    required this.description,
    this.createdAt,
    this.passengerName,
    this.flightNumber,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      passengerId: json['passengerId'] ?? '',
      flightId: json['flightId'] ?? '',
      seatNumber: json['seatNumber'],
      description: json['description'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt']) 
          : null,
      passengerName: json['passengerName'],
      flightNumber: json['flightNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passengerId': passengerId,
      'flightId': flightId,
      'description': description,
    };
  }
}

class CreateBookingRequest {
  final String passengerId;
  final String flightId;
  final String description;

  CreateBookingRequest({
    required this.passengerId,
    required this.flightId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'passengerId': passengerId,
      'flightId': flightId,
      'description': description,
    };
  }
}
