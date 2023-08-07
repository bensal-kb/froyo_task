import 'package:flutter/material.dart';
import 'package:foyer/features/home/home_page.dart';

class Routes {
  static const String init = home;
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
  };
}

getArgs<T>(context) => ModalRoute.of(context)?.settings.arguments as T;
