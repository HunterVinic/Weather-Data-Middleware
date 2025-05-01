class DataFilter {
  static Map<String, dynamic> filterAndValidate(Map<String, dynamic> rawData) {
    print('=== STARTING DATA PROCESSING ===');
    print('Full API Response:');
    print(rawData);

    // Location data
    final location = rawData['location'] ?? {};
    print('\n📍 Location Data:');
    print('Name: ${location['name']}');
    print('Region: ${location['region']}');
    print('Country: ${location['country']}');
    print('Coordinates: (${location['lat']}, ${location['lon']})');
    print('Timezone: ${location['tz_id']}');
    print('Local Time: ${location['localtime']}');

    // Current weather data
    final current = rawData['current'] ?? {};
    if (current.isEmpty) {
      print('❌ ERROR: Missing current weather data');
      throw Exception('Missing current weather data');
    }

    final condition = current['condition'] ?? {};
    print('\n🌤️ Current Weather:');
    print('Last Updated: ${current['last_updated']}');
    print('Temperature: ${current['temp_c']}°C (${current['temp_f']}°F)');
    print('Feels Like: ${current['feelslike_c']}°C (${current['feelslike_f']}°F)');
    print('Wind Chill: ${current['windchill_c']}°C (${current['windchill_f']}°F)');
    print('Heat Index: ${current['heatindex_c']}°C (${current['heatindex_f']}°F)');
    print('Condition: ${condition['text']}');
    print('Weather Icon: ${condition['icon']}');
    print('Is Day: ${current['is_day'] == 1 ? 'Yes' : 'No'}');

    // Wind data
    print('\n🌬️ Wind Information:');
    print('Speed: ${current['wind_kph']} kph (${current['wind_mph']} mph)');
    print('Direction: ${current['wind_degree']}° ${current['wind_dir']}');
    print('Gust Speed: ${current['gust_kph']} kph (${current['gust_mph']} mph)');

    // Atmospheric data
    print('\n📊 Atmospheric Conditions:');
    print('Pressure: ${current['pressure_mb']} mb (${current['pressure_in']} inHg)');
    print('Humidity: ${current['humidity']}%');
    print('Cloud Cover: ${current['cloud']}%');
    print('UV Index: ${current['uv']}');
    print('Visibility: ${current['vis_km']} km (${current['vis_miles']} miles)');

    // Precipitation
    print('\n🌧️ Precipitation:');
    print('Amount: ${current['precip_mm']} mm (${current['precip_in']} in)');

    // Dew point
    print('\n💧 Dew Point:');
    print('Temperature: ${current['dewpoint_c']}°C (${current['dewpoint_f']}°F)');

    // Prepare filtered data structure
    final filteredData = {
      'location': {
        'name': location['name'],
        'region': location['region'],
        'country': location['country'],
        'coordinates': {
          'lat': location['lat'],
          'lon': location['lon'],
        },
        'timezone': location['tz_id'],
        'local_time': location['localtime'],
        'local_time_epoch': location['localtime_epoch'],
      },
      'current': {
        'last_updated': current['last_updated'],
        'last_updated_epoch': current['last_updated_epoch'],
        'temperature': {
          'c': current['temp_c'],
          'f': current['temp_f'],
        },
        'feels_like': {
          'c': current['feelslike_c'],
          'f': current['feelslike_f'],
        },
        'wind_chill': {
          'c': current['windchill_c'],
          'f': current['windchill_f'],
        },
        'heat_index': {
          'c': current['heatindex_c'],
          'f': current['heatindex_f'],
        },
        'condition': {
          'text': condition['text'],
          'icon': condition['icon'],
          'code': condition['code'],
        },
        'wind': {
          'speed_kph': current['wind_kph'],
          'speed_mph': current['wind_mph'],
          'degree': current['wind_degree'],
          'direction': current['wind_dir'],
          'gust_kph': current['gust_kph'],
          'gust_mph': current['gust_mph'],
        },
        'pressure': {
          'mb': current['pressure_mb'],
          'in': current['pressure_in'],
        },
        'precipitation': {
          'mm': current['precip_mm'],
          'in': current['precip_in'],
        },
        'humidity': current['humidity'],
        'cloud': current['cloud'],
        'is_day': current['is_day'] == 1,
        'uv_index': current['uv'],
        'visibility': {
          'km': current['vis_km'],
          'miles': current['vis_miles'],
        },
        'dew_point': {
          'c': current['dewpoint_c'],
          'f': current['dewpoint_f'],
        },
      },
      'timestamp': DateTime.now().toIso8601String(),
      'source_id': 'WeatherAPI',
    };

    print('\n✅ Processed Data Structure:');
    print(filteredData);
    print('=== DATA PROCESSING COMPLETE ===\n');

    return filteredData;
  }
}