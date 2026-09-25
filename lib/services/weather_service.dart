import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    // 1. Find the city's latitude and longitude
    final geoUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
      '?name=${Uri.encodeComponent(city)}'
      '&count=1'
      '&language=en'
      '&format=json',
    );

    final geoResponse = await http.get(geoUrl);

    if (geoResponse.statusCode != 200) {
      throw Exception('Unable to find the city.');
    }

    final geoData = jsonDecode(geoResponse.body);

    if (geoData['results'] == null || (geoData['results'] as List).isEmpty) {
      throw Exception('City not found. Please check the city name.');
    }

    final location = geoData['results'][0];

    final double latitude = location['latitude'];
    final double longitude = location['longitude'];

    final String cityName = location['name'] ?? city;
    final String country = location['country'] ?? '';

    // 2. Get weather using latitude and longitude
    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,is_day,wind_speed_10m'
      '&daily=weather_code,temperature_2m_max,temperature_2m_min'
      '&temperature_unit=celsius'
      '&wind_speed_unit=kmh'
      '&timezone=auto'
      '&forecast_days=5',
    );

    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Unable to fetch weather data.');
    }

    final weatherData = jsonDecode(weatherResponse.body);

    final current = weatherData['current'];
    final daily = weatherData['daily'];

    // 3. Create forecast list
    List<ForecastDay> forecast = [];

    for (int i = 0; i < daily['time'].length; i++) {
      forecast.add(
        ForecastDay(
          date: daily['time'][i],
          maxTemperature: (daily['temperature_2m_max'][i] as num).toDouble(),
          minTemperature: (daily['temperature_2m_min'][i] as num).toDouble(),
          weatherCode: daily['weather_code'][i],
        ),
      );
    }

    // 4. Return WeatherModel
    return WeatherModel(
      city: cityName,
      country: country,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      humidity: current['relative_humidity_2m'],
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: current['weather_code'],
      isDay: current['is_day'] == 1,
      forecast: forecast,
    );
  }
}
