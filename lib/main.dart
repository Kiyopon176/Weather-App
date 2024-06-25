import 'package:flutter/material.dart';
import 'package:task_for_work/pages/Loading.dart';
import 'package:task_for_work/pages/home_page.dart';
import 'package:task_for_work/pages/info_of_city.dart';

void main()  {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => const MyApp(),
      '/info': (context) => const InfoPage(),
    },
  ));
}