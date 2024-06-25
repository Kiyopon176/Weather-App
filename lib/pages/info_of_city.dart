import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'home_page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Map? data;
  Weather? weather;
  String? selectedDate;
  int dayCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = ModalRoute.of(context)?.settings.arguments as Map?;
      if (data != null) {
        String titleName = data?['city'];
        getForecastData(titleName);
      }
    });
  }

  void getForecastData(String cityName) async {
    WeatherService weatherService = WeatherService();
    Weather fetchedWeather = await weatherService.fetchWeather(cityName);
    setState(() {
      weather = fetchedWeather;
      dayCount = weather!.dailyForecasts.length;
      if (fetchedWeather.dailyForecasts.isNotEmpty) {
        selectedDate = fetchedWeather.dailyForecasts.first.date;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(data?['city'] ?? 'Loading...'),
          backgroundColor: const Color(0xFF29B2DD),
        ),
        backgroundColor: const Color(0xFF29B2DD),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(weather!.city),
        backgroundColor: const Color(0xFF29B2DD),
      ),
      backgroundColor: const Color(0xFF29B2DD),
      body: Expanded(
        child: Column(
          children: [
            // List of dates
            Container(
              width: MediaQuery.sizeOf(context).width * 1,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dayCount,
                itemBuilder: (context, index) {
                  String date = weather!.dailyForecasts[index].date;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / dayCount,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: selectedDate == date ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                            color: selectedDate == date ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weather!.dailyForecasts
                    .firstWhere((day) => day.date == selectedDate)
                    .hourlyForecasts
                    .length,
                itemBuilder: (context, index) {
                  var hourlyForecast = weather!.dailyForecasts
                      .firstWhere((day) => day.date == selectedDate)
                      .hourlyForecasts[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${hourlyForecast.time} - ${hourlyForecast.temperature}°C', style: TextStyle(
                        fontSize: 25
                      ),),
                      getWeatherIcon((hourlyForecast.condition).toLowerCase()),
                    ],),
                  );
                  // return ListTile(
                  //   title: Text('${hourlyForecast.time} - ${hourlyForecast.temperature}°C'),
                  //   subtitle: getWeatherIcon((hourlyForecast.condition).toLowerCase()),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
