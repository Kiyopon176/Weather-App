import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_icons/weather_icons.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map?;
    if (data == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF29B2DD),
        body: Center(
          child: Text(
            "No data received",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
    }

    List<String> temps = data!["temperatures"];
    List<String> conditions = data!["conditions"];
    List<String> cities = data!["cities"];

    List<Widget> customCards = [];
    for (int i = 0; i < cities.length; i++) {
      customCards.add(CustomCard(cities[i], temps[i], conditions[i], context));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF29B2DD),
      body: ListView(
        children: customCards,
      ),
    );
  }

  GestureDetector CustomCard(String cityName, String temperature, String conditions, BuildContext context) {
    int temp = int.tryParse(temperature) ?? 0;


    print("Condition inside CustomCard: $conditions"); // Debug message

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/info', arguments: {
          'city': cityName,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white38,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cityName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$temperature°',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: temp <= 0 ? Colors.blue : Colors.yellowAccent,
                  ),
                ),
                getWeatherIcon(conditions)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
SvgPicture getWeatherIcon(String conditions) {
  conditions = conditions.trim();
  print("Received condition: $conditions");

  switch (conditions.toLowerCase()) {
    case "sunny":
    case "clear":
    case "clear sky":
      return SvgPicture.asset("svg/wi-day-sunny.svg");
    case "partly cloudy":
    case "partly sunny":
      return SvgPicture.asset("svg/wi-day-sunny-overcast.svg");
    case "cloudy":
    case "overcast":
      return SvgPicture.asset("svg/wi-cloudy.svg");
    case "rain":
    case "rainy":
    case "patchy rain nearby":
    case "showers":
      return SvgPicture.asset("svg/wi-rain.svg");
    case "thunderstorm":
    case "storm":
    case "thunder":
      return SvgPicture.asset("svg/wi-thunderstorm.svg");
    case "snow":
    case "snowy":
      return SvgPicture.asset("svg/wi-snow.svg");
    case "fog":
    case "foggy":
    case "mist":
    case "haze":
      return SvgPicture.asset("svg/wi-fog.svg");
    case "windy":
      return SvgPicture.asset("svg/wi-wind.svg");
    case "hail":
      return SvgPicture.asset("svg/wi-hail.svg");
    case "sleet":
      return SvgPicture.asset("svg/wi-sleet.svg");
    case "smoke":
      return SvgPicture.asset("svg/wi-smoke.svg");
    case "dust":
      return SvgPicture.asset("svg/wi-dust.svg");
    default:
      print("Condition not recognized: $conditions"); // Debug message
      return SvgPicture.asset("svg/wi-na.svg");
  }
}
