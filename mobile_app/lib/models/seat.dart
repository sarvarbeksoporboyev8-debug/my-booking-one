enum SeatType {
  unknown,
  window,
  middle,
  aisle,
}

enum SeatClass {
  unknown,
  economy,
  business,
  firstClass,
}

class Seat {
  final String id;
  final String seatNumber;
  final SeatType type;
  final SeatClass seatClass;
  final String flightId;
  final bool isReserved;

  Seat({
    required this.id,
    required this.seatNumber,
    required this.type,
    required this.seatClass,
    required this.flightId,
    this.isReserved = false,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'] ?? '',
      seatNumber: json['seatNumber'] ?? '',
      type: SeatType.values[json['type'] ?? 0],
      seatClass: SeatClass.values[json['class'] ?? 0],
      flightId: json['flightId'] ?? '',
      isReserved: json['isReserved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seatNumber': seatNumber,
      'type': type.index,
      'class': seatClass.index,
      'flightId': flightId,
    };
  }

  String get typeText {
    switch (type) {
      case SeatType.window:
        return 'Window';
      case SeatType.middle:
        return 'Middle';
      case SeatType.aisle:
        return 'Aisle';
      default:
        return 'Unknown';
    }
  }

  String get classText {
    switch (seatClass) {
      case SeatClass.economy:
        return 'Economy';
      case SeatClass.business:
        return 'Business';
      case SeatClass.firstClass:
        return 'First Class';
      default:
        return 'Unknown';
    }
  }
}
