// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:project_app/view/forgetPassword_view.dart';
import 'package:project_app/view/shopList_view.dart';
import 'package:project_app/view/register_view.dart';

import 'view/login_view.dart';
import 'view/main_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      initialRoute: 'main_view',
      routes: {
        'login_view': (context) => LoginView(),
        'main_view': (context) => MainView(),
        'register_view': (context) => RegisterView(),
        'shopList_view': (context) => ShopListView(),
        'forgetPassword_view': (context) => ForgetPasswordView(),
      },
    );
  }
}