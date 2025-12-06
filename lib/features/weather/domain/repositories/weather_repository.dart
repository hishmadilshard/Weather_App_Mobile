import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String city);
  Future<Either<Failure, Weather>> getWeatherByLocation(double lat, double lon);
  Future<Either<Failure, List<Forecast>>> getForecast(String city);
  Future<Either<Failure, List<String>>> searchCities(String query);
  Future<Either<Failure, void>> addToFavorites(String city);
  Future<Either<Failure, List<String>>> getFavorites();
  Future<Either<Failure, void>> removeFromFavorites(String city);
}