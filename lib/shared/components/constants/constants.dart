// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=fbd6276f81ad483796ef458b9c76897c
//https://newsapi.org/v2/everything?q=tesla&from=2022-06-12&sortBy=publishedAt&apiKey=fbd6276f81ad483796ef458b9c76897c


// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../styles/colors/colors.dart';

ThemeData lighttheme=ThemeData(
  primarySwatch: defultcolor,
  fontFamily:"Janna" ,
  backgroundColor: Colors.white,
  primaryColor: defultcolor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defultcolor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 20,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),
    //Theme.of(context).textTheme.bodyText1
    bodyText2: TextStyle(fontSize: 13,color: Colors.black),
    subtitle1: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black),
  ),

);
ThemeData darktheme=ThemeData(
  fontFamily:"Janna",
  primaryColor: defultcolor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("333739"),
        statusBarIconBrightness: Brightness.light
    ),
    backgroundColor:HexColor("333739"),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defultcolor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor("333739"),
    elevation: 20,

  ),
  scaffoldBackgroundColor:HexColor("333739") ,
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),
    bodyText2: TextStyle(fontSize: 13,color: Colors.white),
    subtitle1: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.white),
  ),
  primarySwatch: defultcolor,
);


String? token='';
String? uId='';