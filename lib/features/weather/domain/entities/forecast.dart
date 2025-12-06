class Forecast {
  final DateTime date;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  const Forecast({
    required this.date,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });
}