import 'package:desafio_marketeasy/response_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ResposeLogin> getToken(String user, String password) async {
  final String apiURL = "http://servicosflex.rpinfo.com.br:9000/v1.1/auth";
  String json = '{"usuario":' + user + ',"senha":' + password + '}';

  final response = await http.post(apiURL,
      headers: {"Content-Type": "application/json"}, body: json);

  final String responseString = response.body;

  return resposeLoginFromJson(responseString);
}

String? finalEmail;
TextEditingController user = new TextEditingController();
TextEditingController password = new TextEditingController();
String? token;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _homepageWidgetState();
}

class _homepageWidgetState extends State<HomePage> {

  void getSharedPref(SharedPreferences sharedPreferences) {
    if (sharedPreferences.getString('tokenTime') != null) {
      DateFormat format = DateFormat("dd/MM/yyyy HH:mm:ss");
      var tokenTime =
          format.parse(sharedPreferences.getString('tokenTime')) as DateTime;

      print(tokenTime);

      DateTime now = DateTime.now();

      tokenTime.isBefore(now) == false
          ? Navigator.of(context).pushNamed('/products', arguments: token)
          : null;
    } else {
      print("sem token");
    }
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) => getSharedPref(value));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Container(
                height: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      ' MarketEasy',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900]),
                    ),
                    Text(
                      ' challenge',
                      style: TextStyle(fontSize: 30, color: Colors.grey[500]),
                    ),
                  ]),
              Container(
                height: 110,
              ),
              SizedBox(
                height: 70,
                width: 280,
                child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'User'),
                ),
              ),
              Container(
                height: 20,
              ),
              SizedBox(
                height: 70,
                width: 280,
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                ),
              ),
              Container(
                height: 70,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[400],
                      ),
                      onPressed: () async {
                        if (user.text.isEmpty || password.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Login error"),
                                  content: Text(
                                      "Please fill all User and Password fields"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        } else {
                          print("user: " +
                              user.text +
                              " password:" +
                              password.text);

                          final ResposeLogin login =
                              await getToken(user.text, password.text);
                          token = login.response.token;

                          if (login.response.status == "error") {
                            print("usuario invalido ");

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Login error"),
                                    content: Text(
                                        login.response.messages.first.message),
                                    actions: [
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            //tokenTime = DateTime.parse(login.response.tokenExpiration.replaceAll('/', '-'));
                            //print(tokenTime);

                            final SharedPreferences sharedPrefences =
                                await SharedPreferences.getInstance();

                            sharedPrefences.setString('email', user.text);
                            sharedPrefences.setString('token', token!);
                            sharedPrefences.setString(
                                'tokenTime', login.response.tokenExpiration);

                            print(sharedPrefences.getString('email'));
                            print(sharedPrefences.getString('token'));
                            print(sharedPrefences.getString('tokenTime'));

                            Navigator.of(context).pushNamed('/products');
                          }
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 250,
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ]),
              Container(
                height: 70,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
