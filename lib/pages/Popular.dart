import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Constants/EndPoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TopMovies.dart';

//pagina de inicio donde se cargaran las peliculas

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    print(EndPoint.Popular);
    return TopMovies(false);
  }
}
