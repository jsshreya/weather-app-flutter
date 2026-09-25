import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../utils/weather_utils.dart';

class ForecastCard extends StatelessWidget {
  final ForecastDay forecast;

  const ForecastCard({super.key, required this.forecast});

  String getDayName() {
    final date = DateTime.parse(forecast.date);

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getDayName(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Icon(
            getWeatherIcon(forecast.weatherCode, true),
            size: 35,
            color: Colors.blue,
          ),

          const SizedBox(height: 10),

          Text(
            '${forecast.maxTemperature.round()}°',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Text(
            '${forecast.minTemperature.round()}°',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
