import 'dart:convert';
import 'package:http/http.dart' as http;

class DataFetcher {
  static const _apiKey = '70e7409405654b79b11154851252904';

  static Future<Map<String, dynamic>> fetchWeatherData({required String location}) async {
    final url = 'http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$location&aqi=yes';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API fetch failed: ${response.statusCode}');
    }
  }
}
