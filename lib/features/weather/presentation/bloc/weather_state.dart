import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

class ForecastLoading extends WeatherState {}

class ForecastLoaded extends WeatherState {
  final List<Forecast> forecast;

  const ForecastLoaded({required this.forecast});

  @override
  List<Object> get props => [forecast];
}

class ForecastError extends WeatherState {
  final String message;

  const ForecastError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchLoading extends WeatherState {}

class SearchLoaded extends WeatherState {
  final List<String> cities;

  const SearchLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}

class SearchError extends WeatherState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchInitial extends WeatherState {}