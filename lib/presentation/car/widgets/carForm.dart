import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:info_car/bloc/car_bloc.dart';
import 'package:info_car/presentation/car/widgets/customAppbar.dart';
import '../../../data/model/car.dart';

class CarForm extends StatefulWidget {
  final Car? initialCar;
  final Function(Car) onSave;

  const CarForm({
    Key? key,
    this.initialCar,
    required this.onSave,
  }) : super(key: key);

  @override
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _location;
  late double _fuelStatus;
  late double _batteryStatus;

  @override
  void initState() {
    super.initState();
    _name = widget.initialCar?.name ?? '';
    _location = widget.initialCar?.lastKnownLocation ?? '';
    _fuelStatus = widget.initialCar?.status.fuelLevel ?? 100.0;
    _batteryStatus = widget.initialCar?.status.batteryLevel ?? 100.0;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final car = Car(
        id: widget.initialCar?.id ?? UniqueKey().toString(),
        name: _name,
        lastKnownLocation: _location,
        status: Status(
          fuelLevel: _fuelStatus,
          batteryLevel: _batteryStatus,
        ),
      );
      widget.onSave(car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.initialCar == null ? 'Add Car' : 'Update Car'
      ),
      body: BlocListener<CarBloc, CarState>(
        listener: (context, state) {
        if(state is CarAddFailure ){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error,),backgroundColor: Colors.red,showCloseIcon: true,));
           }else  if(state is CarUpdateStatusFailure ){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error,),backgroundColor: Colors.red,showCloseIcon: true,));
           }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(
                    labelText: 'Car Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter car name' : null,
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _location,
                  decoration: const InputDecoration(
                    labelText: 'Last Known Location',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _location = value!,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _fuelStatus.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Fuel Status (%)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final numValue = double.tryParse(value ?? '');
                          if (numValue == null ||
                              numValue < 0 ||
                              numValue > 100) {
                            return 'Enter a value between 0 and 100';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _fuelStatus = double.tryParse(value ?? '0') ?? 0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        initialValue: _batteryStatus.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Battery Status (%)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final numValue = double.tryParse(value ?? '');
                          if (numValue == null ||
                              numValue < 0 ||
                              numValue > 100) {
                            return 'Enter a value between 0 and 100';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _batteryStatus = double.tryParse(value ?? '0') ?? 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Iconsax.car,color: Colors.white,),
                  label: Text(
                      widget.initialCar == null ? 'Add Car' : 'Update Car',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 90, 147, 245),
                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
