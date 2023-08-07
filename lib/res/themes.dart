import 'package:flutter/material.dart';

abstract class Themes {

  Color primary() => const Color(0xff05C268);
  Color primaryLight() => const Color(0xFFE9F9F2);
  Color primaryDark() => const Color(0xFF14BE77);
  Color secondary() => const Color(0xffFFDE85);

  Color title() => const Color(0xff000000);
  Color title2() => const Color(0xff09051C);
  Color titleLight1() => const Color(0xFF787878);



  Color dark() => const Color(0xff000000);
  Color light() => const Color(0xffFFFFFF);

  Color shadow() => const Color(0xff000000).withOpacity(0.2);
  Color warning() => const Color(0xffEF4444);
  Color hint() => const Color(0xFF3B3B3B);

  ///gradients
  List<Color> primaryGradients() => [const Color(0xff03c269), const Color(0xff5bd69b),];

}

class LightThemes extends Themes {}
