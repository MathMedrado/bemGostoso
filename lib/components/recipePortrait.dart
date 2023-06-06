import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipePortrait extends StatelessWidget {
  RecipePortrait({super.key, required this.recipe });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
                recipe.getImage, 
              )
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:  TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyApp.RECIPEDETAIL, arguments: recipe);
            },
            child: Text(
              recipe.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: MyApp.primaryColor
              ),
            ),
          ),
        )
      ],
    );
  }
}