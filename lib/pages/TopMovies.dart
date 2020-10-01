import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Constants/Constants.dart';
import 'package:movie/Constants/EndPoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pagina de inicio donde se cargaran las peliculas

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  @override
  Widget build(BuildContext context) {
    movies(1);
    return Text("hola2");
  }

  Future<void> _showMyDialog(mensaje) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ERROR"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ERROR.'),
                Text(mensaje),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  movies(page) async {
    var response; // donde se va a guardar la respuesta de nuestra peticion
    var conecctionResult = await Connectivity()
        .checkConnectivity(); // para verfificar si tiene algun tipo de conexion
    if (conecctionResult != ConnectivityResult.none) {
      try {
        response = await http.get(EndPoint.Top + page.toString()).timeout(
            const Duration(
                seconds:
                    20)); // si no se optienen resdpuesta en 20 seg se toma como error
      } on TimeoutException catch (_) {
        setState(() {
          _showMyDialog('Sin conexion al servidor\n');
        });
        throw ('Sin conexion al servidor ');
      } on SocketException {
        setState(() {
          _showMyDialog('Sin internet  o falla de servidor ');
        });
        throw ('Sin internet  o falla de servidor ');
      } on HttpException {
        setState(() {
          _showMyDialog('No se encontro esa peticion');
        });
        throw ("No se encontro esa peticion");
      } on FormatException {
        setState(() {
          _showMyDialog('Formato erroneo ');
        });
        throw ("Formato erroneo ");
      }
      var data = json.decode(response.body);
      print(data["results"].length);
    } else {}
  }
}
