import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Desafio CodeTec1',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.teal,
        accentColor: Colors.teal[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        errorColor: Color.fromRGBO(255, 77, 106, 1),
      ),
      themeMode: ThemeMode.light,
      initialRoute: Modular.initialRoute,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
