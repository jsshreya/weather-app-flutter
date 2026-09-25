import 'package:flutter/material.dart';

String getWeatherDescription(int code) {
  if (code == 0) {
    return 'Clear Sky';
  } else if (code == 1) {
    return 'Mainly Clear';
  } else if (code == 2) {
    return 'Partly Cloudy';
  } else if (code == 3) {
    return 'Overcast';
  } else if (code == 45 || code == 48) {
    return 'Foggy';
  } else if (code >= 51 && code <= 57) {
    return 'Drizzle';
  } else if (code >= 61 && code <= 67) {
    return 'Rainy';
  } else if (code >= 71 && code <= 77) {
    return 'Snowy';
  } else if (code >= 80 && code <= 82) {
    return 'Rain Showers';
  } else if (code == 85 || code == 86) {
    return 'Snow Showers';
  } else if (code >= 95) {
    return 'Thunderstorm';
  }

  return 'Unknown';
}

IconData getWeatherIcon(int code, bool isDay) {
  if (code == 0) {
    return isDay ? Icons.wb_sunny : Icons.nightlight_round;
  }

  if (code == 1 || code == 2) {
    return isDay ? Icons.wb_cloudy : Icons.cloud;
  }

  if (code == 3) {
    return Icons.cloud;
  }

  if (code == 45 || code == 48) {
    return Icons.foggy;
  }

  if (code >= 51 && code <= 67) {
    return Icons.water_drop;
  }

  if (code >= 71 && code <= 86) {
    return Icons.ac_unit;
  }

  if (code >= 95) {
    return Icons.thunderstorm;
  }

  return Icons.cloud;
}

Color getWeatherBackground(int code) {
  if (code == 0) {
    return const Color(0xFF4FACFE);
  }

  if (code >= 1 && code <= 3) {
    return const Color(0xFF667DB6);
  }

  if (code >= 51 && code <= 67) {
    return const Color(0xFF4B79A1);
  }

  if (code >= 80 && code <= 82) {
    return const Color(0xFF396A93);
  }

  if (code >= 95) {
    return const Color(0xFF373B44);
  }

  return const Color(0xFF5C6BC0);
}
