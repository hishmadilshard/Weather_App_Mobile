import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetForecast implements UseCase<List<Forecast>, String> {
  final WeatherRepository repository;

  GetForecast(this.repository);

  @override
  Future<Either<Failure, List<Forecast>>> call(String city) async {
    return await repository.getForecast(city);
  }
}