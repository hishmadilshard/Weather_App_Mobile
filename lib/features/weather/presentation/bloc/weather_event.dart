import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherByCity extends WeatherEvent {
  final String city;

  const FetchWeatherByCity(this.city);

  @override
  List<Object> get props => [city];
}

class FetchWeatherByLocation extends WeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeatherByLocation(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}

class FetchForecast extends WeatherEvent {
  final String city;

  const FetchForecast(this.city);

  @override
  List<Object> get props => [city];
}

class SearchCity extends WeatherEvent {
  final String query;

  const SearchCity(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearch extends WeatherEvent {}