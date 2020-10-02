import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Constants/Constants.dart';
import 'package:movie/Constants/EndPoints.dart';
import 'package:movie/Models/Movie.dart';

class Infomovie extends StatefulWidget {
  @override
  Movieinfo movie;
  Infomovie(this.movie);
  _InfomovieState createState() => _InfomovieState(this.movie);
}

class _InfomovieState extends State<Infomovie> {
  Movieinfo movie;
  var genero = [];
  var genname = "";
  _InfomovieState(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(movie.title),
      ),
      body: genero.isNotEmpty ? all() : CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    generos();
  }

  Future<Null> generos() async {
    var response; // donde se va a guardar la respuesta de nuestra peticion
    var conecctionResult = await Connectivity()
        .checkConnectivity(); // para verfificar si tiene algun tipo de conexion
    if (conecctionResult != ConnectivityResult.none) {
      try {
        response = await http.get(EndPoint.Gener).timeout(const Duration(
            seconds:
                15)); // si no se optienen resdpuesta en 20 seg se toma como error
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
      setState(() {
        genero = data["genres"];
      });

      print(movie.genre_ids.length);
      var j = 0;
      for (var i in genero) {
        if (i["id"] == movie.genre_ids[j] && j < movie.genre_ids.length) {
          genname += "[" + (i["name"]) + "]";

          (j < movie.genre_ids.length - 1) ? j++ : j = -1;
        }
        print(j);
        if (j == -1) break;
      }
      print(genname);
    } else {}
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

  all() {
    return Stack(children: <Widget>[
      Image.network(
        Constants.Imagedom + movie.backdrop_path,
        fit: BoxFit.cover,
        height: double.infinity,
        colorBlendMode: BlendMode.luminosity,
        color: Colors.blue.withOpacity(.4),
      ),
      Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .9,
          child: Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.height * .3,
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .02,
                            top: MediaQuery.of(context).size.height * .01,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Image.network(
                              Constants.Imagedom + movie.poster_path)),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Column(children: <Widget>[
                            Container(
                              child: Center(
                                child: Text(
                                  movie.original_title,
                                  style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .02),
                              child: Center(
                                child: Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontFamily: 'Ewert',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .02),
                              child: Center(
                                child: Text(
                                  genname.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Ewert',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .02),
                              child: Center(
                                child: Text(
                                  "Estreno : " + movie.release_date + " ",
                                  style: TextStyle(
                                    fontFamily: 'Ewert',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Row(children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .05,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .05,
                                      top: MediaQuery.of(context).size.height *
                                          .05),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Text(
                                    " " +
                                        (movie.vote_average * 10).toString() +
                                        "% ",
                                    style: TextStyle(
                                        fontFamily: 'Ewert',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Text(
                                    (" Idioma Original: " +
                                            movie.original_language
                                                .toUpperCase()) +
                                        "  ",
                                    style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ]),
                          ]),
                        ),
                      )
                    ],
                  ),
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .015),
                    child: Text(
                      "Sinopsis",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      movie.overview,
                      style: TextStyle(
                          color: Colors.black87, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ))),
    ]);
  }
}
