

/*
desenvolvido por? Luis Fernando Pinto
 */



import 'package:flutter/material.dart';
import 'package:desafio_marketeasy/home_page.dart';
import 'package:desafio_marketeasy/products_page.dart';

import 'home_page.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
       '/products': (context) => products_page(),

      },
    );
  }
}
