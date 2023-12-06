import 'package:flutter/material.dart';
import 'package:tpbdj/ExtraWidget/Lang.dart';
import 'package:tpbdj/ExtraWidget/Methods.dart';
import 'package:tpbdj/ExtraWidget/Styles.dart';
import 'package:tpbdj/Pages/HomePage.dart';
import 'package:tpbdj/Pages/LoginPage.dart';
import 'package:tpbdj/Pages/ProfileListPage.dart';
import 'package:tpbdj/Pages/ReqPassPage.dart';
import 'package:tpbdj/Utilits/Api.dart';

import 'Pages/SplashPage.dart';
Lang sdata = new Lang();
  Styles sheet= new Styles();
  Api apilink= new Api();
  Methods m= new Methods();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
      fontFamily: 'sf' ,
      backgroundColor: sheet.bg,
      
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      initialRoute: '/',
      routes: {
         '/SplashPage':(context)=>SplashPage(),
        '/Login':(context)=>LoginPage(),
        '/Homepage':(context)=> HomePage(),
         '/Profilelist':(context)=> ProfileListPage(),
         
         '/Reqpass':(context)=> ReqPassPage(),
        
      },
    );
  }
}