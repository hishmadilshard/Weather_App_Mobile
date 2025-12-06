import 'package:weather_app/features/weather/domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    required super.date,
    required super.temperature,
    required super.minTemp,
    required super.maxTemp,
    required super.description,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
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

  // Add toEntity method
  Forecast toEntity() {
    return Forecast(
      date: date,
      temperature: temperature,
      minTemp: minTemp,
      maxTemp: maxTemp,
      description: description,
      icon: icon,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }
}