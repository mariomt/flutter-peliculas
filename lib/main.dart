import 'package:flutter/material.dart';

//Pages
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/movie_description.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'description': (BuildContext context) => MovieDescription(),
      },
    );
  }
}
