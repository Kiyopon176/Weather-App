import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';



class WeatherService {
  final String apiKey = '98f670adb2ad436d8b363906242206';
  final String weatherUrl = 'http://api.weatherapi.com/v1/forecast.json';
  var publicresponse;


  Future<Weather> fetchWeather(String city) async {
    print('before response');
    publicresponse = await http.get(Uri.parse('$weatherUrl?key=$apiKey&q=$city&days=4&aqi=no&alerts=no'));
    print("after response");
    if (publicresponse.statusCode == 200) {
      final json = jsonDecode(publicresponse.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
