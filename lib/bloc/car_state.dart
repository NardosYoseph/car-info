part of 'car_bloc.dart';

abstract class CarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarsLoaded extends CarState {
  final List<Car> cars;
  CarsLoaded({required this.cars});

  @override
  List<Object?> get props => [cars];
}

class CarLoadFailure extends CarState {
  final String error;
  CarLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class CarStatusUpdating extends CarState {}

class CarStatusUpdated extends CarState {
  final Car car;
  CarStatusUpdated({required this.car});

  @override
  List<Object?> get props => [car];
}
class CarUpdateStatusFailure extends CarState {
  final String error;
  CarUpdateStatusFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
class CarAddSuccess extends CarState {
  final Car car;
  CarAddSuccess({required this.car});

  @override
  List<Object?> get props => [car];
}

class CarAddFailure extends CarState {
  final String error;
  CarAddFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
