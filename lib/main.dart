import 'package:flutter/material.dart';
import 'package:modulo5/pages/mapa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/mapa' :(context) => const Mapa(),
      },
      initialRoute: '/mapa',
    );
  }
}