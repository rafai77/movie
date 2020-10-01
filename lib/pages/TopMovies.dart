import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Constants/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pagina de inicio donde se cargaran las peliculas

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  @override
  Widget build(BuildContext context) {
    return Text("hola2");
  }
}
