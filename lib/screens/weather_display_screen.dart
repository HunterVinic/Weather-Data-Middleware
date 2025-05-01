import 'package:flutter/material.dart';
import '../main.dart';

class WeatherDisplayScreen extends StatefulWidget {
  const WeatherDisplayScreen({super.key});

  @override
  State<WeatherDisplayScreen> createState() => _WeatherDisplayScreenState();
}

class _WeatherDisplayScreenState extends State<WeatherDisplayScreen> {
  String _selectedLocation = weatherController.location;
  int _updateInterval = weatherController.intervalSeconds;

  final List<String> _locations = ['Bangkok', 'London', 'New York', 'Tokyo', 'Delhi'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => setState(() {}));
    Stream.periodic(const Duration(seconds: 5)).listen((_) => setState(() {}));
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Location: "),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedLocation,
                items: _locations
                    .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLocation = value);
                    weatherController.updateSettings(_selectedLocation, _updateInterval);
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text("Interval (sec): "),
              Expanded(
                child: Slider(
                  min: 10,
                  max: 300,
                  divisions: 29,
                  label: '$_updateInterval s',
                  value: _updateInterval.toDouble(),
                  onChanged: (value) {
                    setState(() => _updateInterval = value.toInt());
                    weatherController.updateSettings(_selectedLocation, _updateInterval);
                  },
                ),
              ),
              Text('$_updateInterval s'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniChart(String title, double value, double maxValue, Color color) {
    final percentage = (value / maxValue * 100).clamp(0, 100);
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 80,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: percentage * 0.8,
                width: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('${value.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(String iconUrl) {
    if (iconUrl.isEmpty) return const SizedBox.shrink();
    return Image.network(
      'https:$iconUrl',
      width: 64,
      height: 64,
    );
  }

  Widget _buildCompactDataRow(String label, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildWeatherSummary(Map<String, dynamic> weather) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather['location']['name'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      weather['current']['condition']['text'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                _buildWeatherIcon(weather['current']['condition']['icon']),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMiniChart('Temp (°C)', (weather['current']['temperature']['c'] as num).toDouble(), 50, Colors.orange),
                _buildMiniChart('Humidity', (weather['current']['humidity'] as num).toDouble(), 100, Colors.blue),
                _buildMiniChart('UV Index', (weather['current']['uv_index'] as num).toDouble(), 15, Colors.purple),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMiniChart('Wind (kph)', (weather['current']['wind']['speed_kph'] as num).toDouble(), 50, Colors.green),
                _buildMiniChart('Pressure', (weather['current']['pressure']['mb'] as num).toDouble(), 2000, Colors.red),
                _buildMiniChart('Clouds', (weather['current']['cloud'] as num).toDouble(), 100, Colors.grey),
              ],
            ),
            const Divider(height: 20),
            _buildCompactDataRow('Feels Like', '${weather['current']['feels_like']['c']}°C'),
            _buildCompactDataRow('Wind Chill', '${weather['current']['wind_chill']['c']}°C'),
            _buildCompactDataRow('Heat Index', '${weather['current']['heat_index']['c']}°C'),
            _buildCompactDataRow('Dew Point', '${weather['current']['dew_point']['c']}°C'),
            _buildCompactDataRow('Precipitation', '${weather['current']['precipitation']['mm']} mm'),
            _buildCompactDataRow('Visibility', '${weather['current']['visibility']['km']} km'),
            _buildCompactDataRow('Wind Direction', '${weather['current']['wind']['direction']}'),
            _buildCompactDataRow('Gust Speed', '${weather['current']['wind']['gust_kph']} kph'),
            _buildCompactDataRow('Last Updated', weather['current']['last_updated']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = List<Map<String, dynamic>>.from(weatherBuffer.reversed);
    if (data.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final latest = data.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildControls(),
            _buildWeatherSummary(latest),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
