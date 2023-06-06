import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/recipePortrait.dart';
import '../main.dart';
import '../models/recipe.dart';

class AuthorSearchPage extends StatefulWidget {
  const AuthorSearchPage({super.key});

  @override
  State<AuthorSearchPage> createState() => _AuthorSearchPageState();
}

class _AuthorSearchPageState extends State<AuthorSearchPage> {


  @override
  Widget build(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    List<Recipe>  listOfRecipes = parameter as List<Recipe>;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    String authorName = listOfRecipes[0].getAuthor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.primaryColor,
        title: Text("Receitas do author $authorName"),
      ),
      body: SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(), 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: ( 150 / 130),
            crossAxisCount: 2
          ),
          itemCount: listOfRecipes.length,
          itemBuilder: (context, index){
            print(listOfRecipes.length);
            return RecipePortrait(recipe: listOfRecipes[index]);
          }
        ),
        ],
      )
    ),
    );
  }
}