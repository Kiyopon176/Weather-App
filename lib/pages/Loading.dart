import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<String> cities = ['Almaty', 'Astana', 'Yakutsk'];
  List<String> temps = [];
  List<String> conditions = [];
  List<Map> data = [];

  @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    for (int i = 0; i < cities.length; i++) {
      WeatherService weatherService = WeatherService();
      Weather weather = await weatherService.fetchWeather(cities[i]);
      temps.add(weather.temperature.toString());
      conditions.add(weather.description.toLowerCase());
    }
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'cities': cities,
      'temperatures': temps,
      'conditions': conditions,
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF29B2DD),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
