// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPadrao(),
      body: SingleChildScrollView(
        child: Column(children: [
         Container(
          decoration: BoxDecoration(color: Colors.blue.shade600),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {Navigator.pushNamed(context, 'login_view');}, child: Text('Registrar-se/Logar',style: TextStyle(color: Colors.white),))
            ],
           ),
         ),
      
         Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height - 233, 
          child: Column(
            children: [

              SizedBox(
                height: 40,
              ),

              SizedBox(
                height: 100,
                width: 200,
                child: Text('Bem vindo ao ShopList!',style: TextStyle(fontSize: 30 ),textAlign: TextAlign.center,),
              ),

               SizedBox(
                height: 40,
              ),

              Image.network('https://th.bing.com/th/id/R.5994de03e2486395a59f39ac792c8f2a?rik=cy43tMRPb5zNKw&pid=ImgRaw&r=0',width: 250,),

              SizedBox(
                height: 40,
              ),

              SizedBox(
                height: 100,
                width: 200,
                child: Text('O melhor app para você fazer suas compras',style: TextStyle(fontSize: 17 ),textAlign: TextAlign.center,),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.black,
                ),
                onPressed: (){Navigator.pushNamed(context, 'login_view');}, 
                child: Text(
                  "Entre Aqui",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),)),

              SizedBox(height: 20,),
            ],
          ),
         ),
         

         Container(
          decoration: BoxDecoration(color: Colors.black),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(
                height: 30,
              ),

              SizedBox(
                width:MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Sobre',style: TextStyle(color: Colors.white, fontSize: 30),textAlign: TextAlign.center,),
                ]),
                  
              ),

              SizedBox(
                height: 30,
              ),

              Container(
                width: MediaQuery.of(context).size.width - 75,
                child: Row(
                  children: <Widget>[
                      Flexible(
                        child: new Text('Sou um estudante chamado Leonardo Fernandes Contrera',
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        textAlign: TextAlign.center,),
                          ),
                      ],
                  ),
              ),

              SizedBox(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width - 75,
                child: Row(
                  children: <Widget>[
                      Flexible(
                        child: new Text('Estudo na Fatec de Ribeirão Preto e meu intuito com este aplicativo é te ajudar nas compras',
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        textAlign: TextAlign.center,),
                          ),
                      ],
                  ),
              ),

              SizedBox(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width - 75,
                child: Row(
                  children: <Widget>[
                      Flexible(
                        child: new Text('O aplicativo tem como objetivo criar listas de compras e permitir que você gerencie os itens destas listas',
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        textAlign: TextAlign.center,),
                          ),
                      ],
                  ),
              ),

              SizedBox(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width - 75,
                child: Row(
                  children: <Widget>[
                      Flexible(
                        child: new Text('Além disso,o projeto foi desenvolvido em Flutter, um framework feito na linguagem Dart que visa produtividade',
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        textAlign: TextAlign.center,),
                          ),
                      ],
                  ),
              ),

              SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width - 125,
                child: Row(
                  children: <Widget>[
                      Flexible(
                        child: new Text('Com isso dito, vamos as compras?',
                        style: TextStyle(color: Colors.white,fontSize: 17),
                        textAlign: TextAlign.center,),
                          ),
                      ],
                  ),
              ),

              SizedBox(height: 40,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.black,
                ),
                onPressed: (){Navigator.pushNamed(context, 'login_view');}, 
                child: Text(
                  "Entre Aqui",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),)),
              
        ]),
         )

        ]),
      ),
    );
  }
  
 AppBar appBarPadrao() {
  return AppBar(
        title: const Text('ShopList', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        foregroundColor: Colors.white,
      );
}
}