import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:info_car/bloc/car_bloc.dart';
import 'package:info_car/data/model/car.dart';
import 'package:info_car/presentation/car/widgets/carDashboard.dart';
import 'package:info_car/presentation/car/widgets/customAppbar.dart';

import '../widgets/carForm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCarForm(BuildContext context, {Car? initialCar}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarForm(
          initialCar: initialCar,
          onSave: (car) {
            final carBloc = context.read<CarBloc>();
            if (initialCar == null) {
              carBloc.add(AddCar(car: car)); // Dispatch event to add a new car
            } else {
              carBloc.add(UpdateCar(
                  car: car)); // Dispatch event to update an existing car
            }
            Navigator.pop(context); // Close the form screen after save
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CarBloc>().add(FetchCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: "Dashboard",),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCarForm(context), // Open form for adding a car
          child: const Icon(Iconsax.add_circle,color: Colors.white,),
          backgroundColor: const Color.fromARGB(255, 90, 147, 245),
        ),
        body: BlocConsumer<CarBloc, CarState>(
          listener: (context, state) {
           if(state is CarLoadFailure){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error,),backgroundColor: Colors.red,showCloseIcon: true,));
          
           }
          },
          builder: (context, state) {
            return BlocBuilder<CarBloc, CarState>(
              builder: (context, state) {
                if (state is CarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CarsLoaded) {
                  return CarDashboard(
                    cars: state.cars,
                    onUpdateCar: (car) => _openCarForm(context,
                        initialCar: car), // Open form for updating a car
                  );
                } else {
                  return const Center(child: Text('No cars available.'));
                }
              },
            );
          },
        ));
  }
}
