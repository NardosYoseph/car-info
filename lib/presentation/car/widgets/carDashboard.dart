import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/model/car.dart';
import 'carCard.dart';

class CarDashboard extends StatelessWidget {
  final List<Car> cars;
  final Function(Car) onUpdateCar;

  const CarDashboard({
    Key? key,
    required this.cars,
    required this.onUpdateCar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: cars.isEmpty
            ? const Center(child: Text('No cars available. Add a new car!'))
            : ListView.separated(
                itemCount: cars.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return CarCard(
                    car: cars[index],
                    onUpdateCar: onUpdateCar,
                  );
                },
              ),
    );
  }
}
