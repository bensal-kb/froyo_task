import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/delays.dart';
import '../utils/logs.dart';

mixin class Base {
  logE(dynamic message, [dynamic content]) => logError(message, content);

  log(dynamic message, [dynamic content]) => logInfo(message, content);

  toast(context, Object message, {bool isError = false}) {
    // ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            backgroundColor: Colors.black,
            content: Text(message.toString(), style: const TextStyle(fontWeight: FontWeight.w700),)));
  }

  Future delay([Duration duration = Delays.sec1]) async =>
      await Future.delayed(duration);

  T provider<T>(context, [bool listen = false]) =>
      Provider.of<T>(context, listen: listen);

  Future navigate(context, String activity, {Object? arguments}) async {
    return Navigator.pushNamed(context, activity, arguments: arguments);
  }

  replace(context, String activity, {Object? arguments}) {
    return Navigator.of(context)
        .pushReplacementNamed(activity, arguments: arguments);
  }

  navigateAndRemoveUntil(context, String activity, {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        activity, (route) => false,
        arguments: arguments);
  }

  pop(context, [result]) {
    return Navigator.of(context).pop(result);
  }

}

enum ThemeType {
  light, dark
}
