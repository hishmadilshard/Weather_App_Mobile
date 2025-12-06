// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getCurrentWeather(city);
        return Right(remoteWeather.toEntity());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByLocation(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await remoteDataSource.getWeatherByLocation(lat, lon);
        return Right(remoteWeather.toEntity());
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Forecast>>> getForecast(String city) async {
    if (await networkInfo.isConnected) {
      try {
        final forecastModels = await remoteDataSource.getForecast(city);
        final forecasts = forecastModels.map((model) => model.toEntity()).toList().cast<Forecast>();
        return Right(forecasts);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchCities(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final cities = await remoteDataSource.searchCities(query);
        return Right(cities);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String city) async {
    try {
      await localDataSource.addFavoriteCity(city);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavoriteCities();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String city) async {
    try {
      await localDataSource.removeFavoriteCity(city);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

extension on ForecastModel {
  toEntity() {}
}

extension on WeatherModel {
  Weather toEntity() {
    throw UnimplementedError('WeatherModel.toEntity() has not been implemented.');
  }
}