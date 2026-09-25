import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../utils/weather_utils.dart';
import '../widgets/forecast_card.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_info_tile.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  final WeatherService weatherService = WeatherService();

  WeatherModel? weather;

  bool isLoading = false;

  String? errorMessage;

  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();

    // Show Bengaluru when the app starts
    searchController.text = 'Bengaluru';

    searchWeather();
  }

  Future<void> searchWeather() async {
    final city = searchController.text.trim();

    if (city.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a city name.';
      });
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await weatherService.getWeather(city);

      setState(() {
        weather = result;
        isLoading = false;

        // Add city to search history
        if (!searchHistory.contains(result.city)) {
          searchHistory.insert(0, result.city);
        }

        // Keep only last 5 cities
        if (searchHistory.length > 5) {
          searchHistory.removeLast();
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;

        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void selectHistory(String city) {
    searchController.text = city;
    searchWeather();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = weather == null
        ? const Color(0xFF4FACFE)
        : getWeatherBackground(weather!.weatherCode);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.65),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ---------------- HEADER ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'SkyCast',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Live Weather',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: widget.onThemeChanged,

                      icon: Icon(
                        widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,

                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ---------------- SEARCH BAR ----------------
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: TextField(
                    controller: searchController,

                    textInputAction: TextInputAction.search,

                    onSubmitted: (_) {
                      searchWeather();
                    },

                    decoration: InputDecoration(
                      hintText: 'Search city...',

                      prefixIcon: const Icon(Icons.search),

                      suffixIcon: IconButton(
                        onPressed: searchWeather,

                        icon: const Icon(Icons.arrow_forward),
                      ),

                      border: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(vertical: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------------- SEARCH HISTORY ----------------
                if (searchHistory.isNotEmpty)
                  SizedBox(
                    height: 40,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: searchHistory.length,

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),

                          child: ActionChip(
                            label: Text(searchHistory[index]),

                            onPressed: () {
                              selectHistory(searchHistory[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 20),

                // ---------------- LOADING ----------------
                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(50),

                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),

                // ---------------- ERROR ----------------
                if (!isLoading && errorMessage != null)
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.15),

                      borderRadius: BorderRadius.circular(20),

                      border: Border.all(color: Colors.redAccent),
                    ),

                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 50,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          errorMessage!,
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                // ---------------- WEATHER DATA ----------------
                if (!isLoading && errorMessage == null && weather != null) ...[
                  WeatherCard(weather: weather!),

                  const SizedBox(height: 20),

                  // ---------------- WEATHER DETAILS ----------------
                  GridView.count(
                    crossAxisCount: 2,

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    mainAxisSpacing: 12,

                    crossAxisSpacing: 12,

                    childAspectRatio: 1.6,

                    children: [
                      WeatherInfoTile(
                        icon: Icons.water_drop,

                        title: 'Humidity',

                        value: '${weather!.humidity}%',
                      ),

                      WeatherInfoTile(
                        icon: Icons.air,

                        title: 'Wind',

                        value: '${weather!.windSpeed.round()} km/h',
                      ),

                      WeatherInfoTile(
                        icon: Icons.thermostat,

                        title: 'Feels Like',

                        value: '${weather!.feelsLike.round()}°C',
                      ),

                      WeatherInfoTile(
                        icon: Icons.cloud,

                        title: 'Condition',

                        value: getWeatherDescription(weather!.weatherCode),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ---------------- FORECAST TITLE ----------------
                  const Text(
                    '5-Day Forecast',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---------------- FORECAST ----------------
                  SizedBox(
                    height: 160,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: weather!.forecast.length,

                      itemBuilder: (context, index) {
                        return ForecastCard(forecast: weather!.forecast[index]);
                      },
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                // ---------------- FOOTER ----------------
                Center(
                  child: Text(
                    'Weather data powered by Open-Meteo',

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),

                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
