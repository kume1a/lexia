import 'package:flutter/material.dart';
import 'package:lexia/pages/welcome_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Lexia', debugShowCheckedModeBanner: false, home: WelcomePage());
  }
}
