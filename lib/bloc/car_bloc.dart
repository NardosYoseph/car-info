import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:info_car/data/model/car.dart';
import 'package:info_car/data/repository/carRepository.dart';
import 'package:meta/meta.dart';

part 'car_event.dart';
part 'car_state.dart';
class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository carRepository;

  CarBloc({required this.carRepository}) : super(CarInitial()) {
    on<FetchCars>(_onFetchCars);
    on<AddCar>(_onAddCar);
    on<UpdateCar>(_onUpdateCar);
  }

  Future<void> _onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final response = await carRepository.fetchCars();
      print("response $response");
      emit(CarsLoaded(cars: response));
    } catch (e) {
      emit(CarLoadFailure(error: "Failed to fetch cars: ${e.toString()}"));
    }
  }

  Future<void> _onAddCar(AddCar event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      print("car to be added ${event.car.status.batteryLevel}");
      print("car to be added ${event.car.name}");
      print("car to be added ${event.car.lastKnownLocation}");
      await carRepository.addCar(event.car);
      final cars = await carRepository.fetchCars(); // Optionally refresh the car list
      emit(CarsLoaded(cars: cars));
    } catch (e) {
      emit(CarAddFailure(error: "Failed to add car: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateCar(UpdateCar event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      await carRepository.updateCarStatus(event.car);
      final cars = await carRepository.fetchCars(); // Optionally refresh the car list
      emit(CarsLoaded(cars: cars));
    } catch (e) {
      emit(CarUpdateStatusFailure(error: "Failed to update car: ${e.toString()}"));
    }
  }
}

