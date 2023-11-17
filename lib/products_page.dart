import 'dart:convert';

import 'package:desafio_marketeasy/home_page.dart';
import 'package:desafio_marketeasy/response_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Products produtos = new Products();

Future<Products> getProducts(String token) async {
  final String apiURL =
      "http://servicosflex.rpinfo.com.br:9000/v2.0/produtounidade/listaprodutos/0/unidade/83402711000110";

  final response = await http.get(apiURL, headers: {
    "Content-Type": "application/json",
    'token': token,
  });

  final String responseString = response.body;
  print(responseString);

  return Products.fromJson(jsonDecode(responseString));
}

/// This is the stateful widget that the main application instantiates.
class products_page extends StatefulWidget {


  const products_page({Key? key}) : super(key: key);

  @override
  State<products_page> createState() => _products_pageWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _products_pageWidgetState extends State<products_page> {
  List<int> top = <int>[];
  List<int> bottom = <int>[0];
  Future<Products>? future_produtos;
int itemCount = 0;
  Produtos p = new Produtos();

  void removeSharedPref(SharedPreferences sharedPreferences){

    sharedPreferences.clear();
  }
  String? token;
  void setToken(SharedPreferences sharedPreferences){

    token = sharedPreferences.getString('token');
    print(token);
}
  @override
  void initState(){

    SharedPreferences.getInstance().then((value) => setToken(value));

  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');



    return Scaffold(

      appBar: AppBar(
        title: const Text('Logout'),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app), onPressed: (
            ) {

          SharedPreferences.getInstance().then((value) => removeSharedPref(value));
            Navigator.pop(context);



            },

        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),

                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {

                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      color: Colors.red[50],

                      child: Column(
                          children:  <Widget>[

                           Text('${produtos.response!.produtos![index].descricao} ',
                            style: TextStyle(fontSize: 18),
                          ),
                            Text('Valor: ${produtos.response!.produtos![index].preco} ',
                              style: TextStyle(fontSize: 18),
                            ),

                          ],
                        
                        
                      ),
                    );
                  }
              )
          ),



          Container(

              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[300],
                      ),
                      onPressed: () {
                        print(token);
                        SnackBar mySnackbar =
                        SnackBar(content: Text("Loading products"));
                        ScaffoldMessenger.of(context).showSnackBar(mySnackbar);

                        getProducts(token!).then((value) => updateProduct(value));

                        // print(products.response!.produtos![i].descricao);
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        alignment: Alignment.center,
                        child: Text(
                          "Refresh list",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
  void updateProduct(Products produtosAux){
    setState(()  {
      produtos=produtosAux;
      itemCount = produtos.response!.produtos!.length;

    });

  }
}
