import 'package:bemgostoso/models/user.dart';
import 'package:bemgostoso/pages/editUserProfile.dart';
import 'package:bemgostoso/pages/excludProfile.dart';
import 'package:bemgostoso/pages/homePage.dart';
import 'package:bemgostoso/pages/login.dart';
import 'package:bemgostoso/pages/recipeDetail.dart';
import 'package:bemgostoso/pages/registryUser.dart';
import 'package:bemgostoso/pages/searchPage.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

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

  static const primaryColor = Color.fromARGB(1000, 235, 69, 17);

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
        SEARCH_PAGE: (context) => const SearchPage()
      },
    );
  }
}
