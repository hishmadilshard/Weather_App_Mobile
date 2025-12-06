class Weather {
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

  const Weather({
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
}