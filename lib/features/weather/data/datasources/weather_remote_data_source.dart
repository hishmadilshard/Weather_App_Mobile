// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/errors/exceptions.dart' show ServerException;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String city);
  Future<List<ForecastModel>> getForecast(String city);
  Future<WeatherModel> getWeatherByLocation(double lat, double lon);
  Future<List<String>> searchCities(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    final response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to load weather data');
    }
  }

  @override
  Future<List<ForecastModel>> getForecast(String city) async {
    final response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=YOUR_API_KEY&units=metric&cnt=5'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> forecastList = data['list'];
      return forecastList
          .map((item) => ForecastModel.fromJson(item))
          .toList();
    } else {
      throw ServerException(message: 'Failed to load forecast data');
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    final response = await client.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=YOUR_API_KEY&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to load location weather data');
    }
  }

  @override
  Future<List<String>> searchCities(String query) async {
    // Mock implementation - you can replace with actual API call
    final cities = [
      'London',
      'New York',
      'Tokyo',
      'Paris',
      'Sydney',
      'Dubai',
      'Singapore',
      'Berlin',
      'Rome',
      'Madrid'
    ];
    
    return cities
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

// Add these model classes here temporarily
class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final String description;
  final String icon;
  final DateTime date;
  final double? minTemp;
  final double? maxTemp;
  final int sunrise;
  final int sunset;
  final double? visibility;
  final int cloudiness;

  const WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.date,
    this.minTemp,
    this.maxTemp,
    required this.sunrise,
    required this.sunset,
    this.visibility,
    required this.cloudiness,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      minTemp: json['main']['temp_min']?.toDouble(),
      maxTemp: json['main']['temp_max']?.toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      visibility: json['visibility']?.toDouble(),
      cloudiness: json['clouds']['all'],
    );
  }
}

class ForecastModel {
  final DateTime date;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  const ForecastModel({
    required this.date,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}