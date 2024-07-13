import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather.dart';

class DataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      final queryParameters = {
        'q': cityName,
        'appid': 'ce9e1deaf8a59996ee93d9cd5abb3abc',
        'units': 'imperial',
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Weather');
      }
    } catch (e) {
      rethrow;
    }
  }
}
