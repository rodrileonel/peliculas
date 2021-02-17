import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Películas',
    initialRoute: '/',
    routes: {
      '/' : (BuildContext context) => HomePage(),
      'pelicula' : (BuildContext context) => PeliculaPage(),
    },
  );
}