import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Constants/Constants.dart';
import 'package:movie/Constants/EndPoints.dart';
import 'package:movie/Models/Movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

//pagina de inicio donde se cargaran las peliculas

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  int page = 1;
  int total_result = 0;
  int total_pages = 0;
  StreamController<List<Movieinfo>> MovieTop =
      StreamController<List<Movieinfo>>();
  List<Movieinfo> aux = List<Movieinfo>();

  @override
  void initState() {
    // TODO: implement initState
    movies();
    super.initState();
  }

  Future<Null> actulizar() async {
    this.page = 1;
    movies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .75,
          child: StreamBuilder(
              stream: MovieTop.stream,
              builder: (BuildContext contex, AsyncSnapshot snapshot) {
                if (aux.length == 0) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .35),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      ]);
                }
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .9,
                        child: Center(
                          child: Container(
                            child: Center(
                              child: RefreshIndicator(
                                onRefresh: actulizar,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext contex, int index) {
                                      if (index >= aux.length - 1) {
                                        page++;
                                        movies();
                                      }
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.black26,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        margin: EdgeInsets.only(bottom: 15),
                                        padding: EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .01,
                                                ),
                                                alignment: Alignment.bottomLeft,
                                                child: Image.network(
                                                    Constants.Imagedom +
                                                        snapshot.data[index]
                                                            .poster_path)),
                                            Flexible(
                                                child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Center(
                                                          child: Text(
                                                            snapshot.data[index]
                                                                .original_title,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'RobotoMono',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              bottom: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .07),
                                                          child: Text(
                                                            "(" +
                                                                snapshot
                                                                    .data[index]
                                                                    .title +
                                                                ")",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'RobotoMono',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Row(children: <Widget>[
                                                          Container(
                                                              margin: EdgeInsets.only(
                                                                  left: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .22),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black26,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(100))),
                                                              child: Text(
                                                                (snapshot.data[index].vote_average *
                                                                            10)
                                                                        .toString() +
                                                                    "%",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'RobotoMono',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black26,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(50))),
                                                              child: Text(
                                                                ("  " + snapshot.data[index].original_language)
                                                                        .toUpperCase() +
                                                                    "  ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'RobotoMono',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ]),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .05,
                                                            ),
                                                            child: Text(
                                                              "Estreno  " +
                                                                  (snapshot
                                                                      .data[
                                                                          index]
                                                                      .release_date),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'RobotoMono',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )),
                                                      ],
                                                    )))
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]);
              })),
      Container(
          margin: EdgeInsets.only(
              top: 0, left: MediaQuery.of(context).size.width * .45),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  " " +
                      this.page.toString() +
                      " / " +
                      this.total_pages.toString() +
                      " ",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ))
    ]);
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

  Future<Null> movies() async {
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
      this.page = data["page"];
      this.total_pages = data["total_pages"];
      this.total_result = data["total_results"];
      var dat = Movieinfo.Jondec(data["results"]);
      setState(() {
        (page == 1) ? aux = dat : aux.addAll(dat);
      });

      print(aux.length);
      MovieTop.add(aux);

      //print(MovieTop.length);
    } else {}
  }
}
