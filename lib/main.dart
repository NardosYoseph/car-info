import 'package:flutter/material.dart';
import 'package:info_car/presentation/car/screens/homeScreen.dart';
import 'package:info_car/presentation/car/widgets/carDashboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/car_bloc.dart';
import 'data/repository/carRepository.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<CarBloc>(
          create: (context) => CarBloc(carRepository: CarRepository()),
        
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
