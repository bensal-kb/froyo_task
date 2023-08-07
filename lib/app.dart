import 'package:flutter/material.dart';
import 'package:foyer/base/base_vm.dart';
import 'package:foyer/res/strings.dart';
import 'package:foyer/res/theme.dart';
import 'package:foyer/routes.dart';
import 'package:foyer/vm/empty_vm.dart';
import 'package:foyer/vm/global_vm.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider(create: (context) => AuthRepo()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => GlobalVM()),
        ChangeNotifierProvider(create: (context) => BaseVM()),
        ChangeNotifierProvider(create: (context) => EmptyVM()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeModel().theme(context),
        title: Strings.appName,
        routes: Routes.routes,
        initialRoute: Routes.init,
      ),
    );
  }
}
