import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_app/screens/main_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
