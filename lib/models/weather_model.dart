class WeatherModel {
  final String city;
  final String country;

  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  final int weatherCode;
  final bool isDay;

  final List<ForecastDay> forecast;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.isDay,
    required this.forecast,
  });
}

class ForecastDay {
  final String date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  ForecastDay({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
  });
}
