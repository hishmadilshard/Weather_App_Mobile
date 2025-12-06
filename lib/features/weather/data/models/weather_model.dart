import 'package:weather_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.city,
    required super.country,
    required super.temperature,
    required super.feelsLike,
    required super.humidity,
    required super.pressure,
    required super.windSpeed,
    required super.description,
    required super.icon,
    required super.date,
    super.minTemp,
    super.maxTemp,
    required super.sunrise,
    required super.sunset,
    super.visibility,
    required super.cloudiness,
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