import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? id;
  String name;
  String lastKnownLocation;
  Status status;

  Car({
    this.id,
    required this.name,
    required this.lastKnownLocation,
    required this.status,
  });

  factory Car.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Car(
      id: doc.id,
      name: data['name'] ?? '',
      lastKnownLocation: data['lastKnownLocation'] ?? '',
      status: Status.fromFirestore(data['status'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': this.name,
      'lastKnownLocation': this.lastKnownLocation,
      'status': this.status.toFirestore(), // Serialize Status properly
    };
  }
}

class Status {
  double batteryLevel;
  double fuelLevel;

  Status({
    required this.batteryLevel,
    required this.fuelLevel,
  });

  factory Status.fromFirestore(Map<String, dynamic> data) {
    return Status(
      fuelLevel: data['fuelLevel'] ?? 0.0,
      batteryLevel: data['batteryLevel'] ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
    };
  }
}
