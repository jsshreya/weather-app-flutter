import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../utils/weather_utils.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            weather.city,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            weather.country,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 20),

          Icon(
            getWeatherIcon(weather.weatherCode, weather.isDay),
            color: Colors.white,
            size: 90,
          ),

          const SizedBox(height: 10),

          Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            getWeatherDescription(weather.weatherCode),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),

          const SizedBox(height: 10),

          Text(
            'Feels like ${weather.feelsLike.round()}°C',
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
