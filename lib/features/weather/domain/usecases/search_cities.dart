import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class SearchCities implements UseCase<List<String>, String> {
  final WeatherRepository repository;

  SearchCities(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(String query) async {
    return await repository.searchCities(query);
  }
}