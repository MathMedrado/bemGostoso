import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/recipePortrait.dart';
import '../main.dart';
import '../models/recipe.dart';

class CategorySearchPage extends StatefulWidget {
  const CategorySearchPage({super.key});

  @override
  State<CategorySearchPage> createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends State<CategorySearchPage> {


  @override
  Widget build(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    List<Recipe>  listOfRecipes = parameter as List<Recipe>;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    String categoryName = "";
    if(listOfRecipes.length >= 1){
      categoryName = listOfRecipes[0].getCategoryName;
    }

    return  
    Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.primaryColor,
        title: Text("$categoryName"),
      ),
      body: SingleChildScrollView(
      child: listOfRecipes.length >=1 ? Column(
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
      ): Container()
    ) ,
    );
  }
}