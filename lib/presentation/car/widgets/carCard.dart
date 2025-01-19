import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/model/car.dart';
import 'circularIndicator.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final Function(Car) onUpdateCar;

  const CarCard({
    Key? key,
    required this.car,
    required this.onUpdateCar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade100,
                      child: const Icon(Iconsax.car, size: 28, color: Colors.blueGrey),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        car.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircularIndicator(
                      percentage: car.status.fuelLevel.toDouble(),
                      color: Colors.teal,
                      label: 'Fuel',
                    ),
                const SizedBox(width: 30),

                    CircularIndicator(
                      percentage: car.status.batteryLevel.toDouble(),
                      color: Colors.amber,
                      label: 'Battery',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Iconsax.location, size: 16, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Last Location: ${car.lastKnownLocation}',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Iconsax.edit_2, size: 20, color: Colors.black87),
              onPressed: () => onUpdateCar(car),
            ),
          ),
        ],
      ),
    );
  }
}
