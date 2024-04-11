// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_app/view/login_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopList'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
         Container(
          decoration: BoxDecoration(color: Colors.blue),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode_outlined,color: Colors.white,)),
              ],),
              TextButton(onPressed: () {Navigator.pushNamed(context, 'login');}, child: Text('Registrar-se/Logar',style: TextStyle(color: Colors.white),))
            ],
           ),
         ),
      
         Container(
          width: double.maxFinite,
          height: 1000,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Column(
            children: const [

              SizedBox(
                height: 50,
              ),

              SizedBox(
                height: 200,
                width: 200,
                child: Text('Bem vindo ao ShopList!',style: TextStyle(fontSize: 30)),
              ),

              Image(
                image: NetworkImage('https://www.dreamstime.com/shopping-cart-icon-vector-sale-image170608151'),
              )
            ],
          ),
         ),
         

         Container(
          decoration: BoxDecoration(color: Colors.black),
          width: double.maxFinite,
          height: 83,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                child: 
                  Row(children: [
                    Text('Sobre mim',style: TextStyle(color: Colors.white)),
                  ]),
              ),
            ],
          ),
         )

        ]),
      ),
    );
  }
}
