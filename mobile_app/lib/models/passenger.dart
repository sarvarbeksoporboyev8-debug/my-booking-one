enum PassengerType {
  unknown,
  male,
  female,
  baby,
}

class Passenger {
  final String id;
  final String name;
  final String passportNumber;
  final PassengerType passengerType;
  final int age;

  Passenger({
    required this.id,
    required this.name,
    required this.passportNumber,
    required this.passengerType,
    required this.age,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      passportNumber: json['passportNumber'] ?? '',
      passengerType: PassengerType.values[json['passengerType'] ?? 0],
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'passportNumber': passportNumber,
      'passengerType': passengerType.index,
      'age': age,
    };
  }

  String get passengerTypeText {
    switch (passengerType) {
      case PassengerType.male:
        return 'Male';
      case PassengerType.female:
        return 'Female';
      case PassengerType.baby:
        return 'Baby';
      default:
        return 'Unknown';
    }
  }
}
