import 'package:flutter/material.dart';
import 'package:movie/pages/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Movie());
}

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.favorite_border)),
                  Tab(icon: Icon(Icons.star)),
                ],
              ),
              title: Center(child: Text('Movies')),
            ),
            body: Home()),
      ),
    );
  }
}
