import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/pages/Popular.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pagina de inicio donde se cargaran las peliculas

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Popular(),
        Icon(Icons.directions_transit),
      ],
    );
  }
}
