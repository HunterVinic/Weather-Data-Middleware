import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_service.dart';
import 'screens/weather_display_screen.dart';
import 'services/data_fetcher.dart';
import 'services/data_filter.dart';
import 'services/data_formatter.dart';

final List<Map<String, dynamic>> weatherBuffer = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WeatherApp());
  weatherController.start();
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherDisplayScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherController {
  Timer? _timer;
  String _location = 'Bangkok';
  int _intervalSeconds = 60;

  String get location => _location;
  int get intervalSeconds => _intervalSeconds;

  void start() {
    _restartFetching();
  }

  void updateSettings(String newLocation, int newInterval) {
    _location = newLocation;
    _intervalSeconds = newInterval;
    _restartFetching();
  }

  void _restartFetching() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: _intervalSeconds), (_) => fetchAndStoreWeatherData());
    fetchAndStoreWeatherData(); // immediate fetch
  }

  Future<void> fetchAndStoreWeatherData() async {
    try {
      final raw = await DataFetcher.fetchWeatherData(location: _location);
      final filtered = DataFilter.filterAndValidate(raw);
      final formatted = DataFormatter.formatToJson(filtered);
      weatherBuffer.add(formatted);
      if (weatherBuffer.length > 20) weatherBuffer.removeAt(0);
      await FirestoreService().addWeatherData(formatted);
    } catch (e) {
      print("⚠️ Fetch/store error: $e");
    }
  }

  void dispose() => _timer?.cancel();
}

final weatherController = WeatherController();
