// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_forecast.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_by_location.dart';
import 'package:weather_app/features/weather/domain/usecases/search_cities.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetForecast getForecast;
  final SearchCities searchCities;
  final GetWeatherByLocation getWeatherByLocation;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getForecast,
    required this.searchCities,
    required this.getWeatherByLocation,
  }) : super(WeatherInitial()) {
    on<FetchWeatherByCity>(_onFetchWeatherByCity);
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);
    on<FetchForecast>(_onFetchForecast);
    on<SearchCity>(_onSearchCity);
  }

  Future<void> _onFetchWeatherByCity(
    FetchWeatherByCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await getCurrentWeather(event.city);
    result.fold(
      (failure) => emit(WeatherError(failure.toString())),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  Future<void> _onFetchWeatherByLocation(
    FetchWeatherByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await getWeatherByLocation((event.latitude, event.longitude));
    result.fold(
      (failure) => emit(WeatherError(failure.toString())),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }

  Future<void> _onFetchForecast(
    FetchForecast event,
    Emitter<WeatherState> emit,
  ) async {
    emit(ForecastLoading());
    final result = await getForecast(event.city);
    result.fold(
      (failure) => emit(ForecastError(failure.toString())),
      (forecast) => emit(ForecastLoaded(forecast: forecast)),
    );
  }

  Future<void> _onSearchCity(
    SearchCity event,
    Emitter<WeatherState> emit,
  ) async {
    emit(SearchLoading());
    final result = await searchCities(event.query);
    result.fold(
      (failure) => emit(SearchError(failure.toString())),
      (cities) => emit(SearchLoaded(cities: cities)),
    );
  }
}