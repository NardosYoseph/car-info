part of 'car_bloc.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

class FetchCars extends CarEvent {}

class AddCar extends CarEvent {
  final Car car;
  AddCar({required this.car});

  @override
  List<Object?> get props => [car];
}

class UpdateCar extends CarEvent {
  final Car car;
  UpdateCar({required this.car});

  @override
  List<Object?> get props => [car];
}


