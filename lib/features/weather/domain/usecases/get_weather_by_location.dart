import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByLocation implements UseCase<Weather, (double, double)> {
  final WeatherRepository repository;

  GetWeatherByLocation(this.repository);

  @override
  Future<Either<Failure, Weather>> call((double, double) params) async {
    final (lat, lon) = params;
    return await repository.getWeatherByLocation(lat, lon);
  }
}