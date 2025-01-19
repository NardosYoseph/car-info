import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';

class CarProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Car>> fetchCars() async {
    try {
      final querySnapshot = await _firestore.collection('cars').get();
      return querySnapshot.docs.map((doc) => Car.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching vehicles: $e");
      throw Exception("Failed to fetch vehicles: $e");
    }
  }

Future<Car> fetchCarById(String carId) async {
    try {
      final docSnapshot = await _firestore.collection('cars').doc(carId).get();
      return Car.fromFirestore(docSnapshot);
    } catch (e) {
      print("Error fetching vehicle: $e");
      throw Exception("Failed to fetch vehicle: $e");
    }
  }

  Future<void> addCar(Car car) async {
    try {
      await _firestore.collection('cars').add(car.toFirestore());
    } catch (e) {
      print("Error adding vehicle: $e");
      throw Exception("Failed to add vehicle: $e");
    }
  }

  Future<void> updateCar(Car car) async {
    try {
      await _firestore.collection('cars').doc(car.id).update(car.toFirestore());
    } catch (e) {
      print("Error updating vehicle status: $e");
      throw Exception("Failed to update vehicle status: $e");
    }
  }
}
