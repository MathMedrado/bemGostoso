import 'dart:convert';

import 'package:bemgostoso/models/user.dart';
import 'package:bemgostoso/pages/authorSearchPage.dart';
import 'package:bemgostoso/pages/categorySearchPage.dart';
import 'package:bemgostoso/pages/editUserProfile.dart';
import 'package:bemgostoso/pages/excludProfile.dart';
import 'package:bemgostoso/pages/forgetPassword.dart';
import 'package:bemgostoso/pages/homePage.dart';
import 'package:bemgostoso/pages/login.dart';
import 'package:bemgostoso/pages/recipeDetail.dart';
import 'package:bemgostoso/pages/registryUser.dart';
import 'package:bemgostoso/pages/searchPage.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const HOME = '/';
  static const LOGIN = 'login';
  static const APPHOME = 'app_home';
  static const REGISTER = 'registry_user';
  static const HOMEPAGE =  'home_page';
  static const EDITUSER =  'edit_user';
  static const EXCLUDPROFILE = 'exclud_profile';
  static const RECIPEDETAIL = 'recipe_detail';
  static const SEARCH_PAGE = 'search_page';
  static const FORGET_PASSWORD = 'forget_password';
  static const CATEGORY_PAGE = "category_page";
  static const AUTHOR_PAGE = "author_page";

  static const primaryColor = Color.fromARGB(1000, 235, 69, 17);
  //static const String baseUrl = "http://10.0.2.2:8000";
  static const String baseUrl = "http://34.132.14.26";

  static Future<String?> getUsername() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? username =  sharedPreference.getString("email");

    return username;
  }

  static Future<String?> getPassword() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? username = sharedPreference.getString("password");

    return username;
  }

  static Future<String> getBasicAuthentication() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? username =  sharedPreference.getString("email");
    String? password = sharedPreference.getString("password");
    
    var auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    return auth;
  }

  static List<String> manipulationListIngredient(String ingredientsString) {
    String productsFormat = ingredientsString.replaceAll('[', '');
    String resultFormat = productsFormat.replaceAll(']', '');
    List<String> productArray = resultFormat.split(", ");
    
    return List<String>.from(productArray);
 }


  static Future<int?> getUserId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    int? userId = sharedPreference.getInt("userId");

    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: const Home(),
      routes: {
        LOGIN:(context) => const Login(),
        APPHOME: (context) => const Home(),
        REGISTER: (context) => const RegistryUser(),
        HOMEPAGE:(context) => const HomePage(),
        EDITUSER:(context) => EditUserProfile(),
        EXCLUDPROFILE: (context) => ExcludProfile(),
        RECIPEDETAIL: (context) => const RecipeDetail(),
        SEARCH_PAGE: (context) => const SearchPage(),
        FORGET_PASSWORD: (context) => const ForgetPassword(),
        CATEGORY_PAGE:(context) => const CategorySearchPage(),
        AUTHOR_PAGE: (context) => const AuthorSearchPage()
      },
    );
  }
}
