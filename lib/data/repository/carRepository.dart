import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';
import '../provider/carProvider.dart';

class CarRepository {
  final CarProvider _carProvider;

  CarRepository({CarProvider? carProvider}) : _carProvider = carProvider ?? CarProvider();

  /// Fetch all vehicles
  Future<List<Car>> fetchCars() async {
    try {
      return await _carProvider.fetchCars();
    } catch (e) {
      print("Error fetching vehicles: $e");
      throw Exception("Failed to fetch vehicles: $e");
    }
  }

  /// Fetch a single vehicle by its ID
  Future<Car> fetchCarById(String carId) async {
    try {
      return await _carProvider.fetchCarById(carId);
    } catch (e) {
      print("Error fetching vehicle: $e");
      throw Exception("Failed to fetch vehicle: $e");
    }
  }

  /// Add a new vehicle
  Future<void> addCar(Car car) async {
    try {
      await _carProvider.addCar(car);
    } catch (e) {
      print("Error adding vehicle: $e");
      throw Exception("Failed to add vehicle: $e");
    }
  }

  /// Update an existing vehicle's status or information
  Future<void> updateCarStatus(Car car) async {
    try {
      await _carProvider.updateCar(car);
    } catch (e) {
      print("Error updating vehicle status: $e");
      throw Exception("Failed to update vehicle status: $e");
    }
  }
}
