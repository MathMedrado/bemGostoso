import 'package:bemgostoso/components/recipeTitles.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:bemgostoso/models/Ingredients.dart';

import '../components/defaultButton.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({super.key});
  

  @override
  Widget build(BuildContext context) {

    var parameter = ModalRoute.of(context)!.settings.arguments;
    Recipe recipe = parameter as Recipe;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    final Ingredients ingredients = Ingredients(id: 1, name: ["Leite", "farinha", "Morangos", "Ovos", "Pouvilho", "Manteiga"]);
    final List<String> ListOfIngredients = ingredients.getName;
    final List<String> ListOfPreparationMethods = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non ultrices massa. Nam porttitor ante a sodales tempus. Donec ac aliquam diam. Morbi risus metus, molestie et scelerisque at, cursus.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non ultrices massa. Nam porttitor ante a sodales tempus. Donec ac aliquam diam. Morbi risus metus, molestie et scelerisque at, cursus.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non ultrices massa. Nam porttitor ante a sodales tempus. Donec ac aliquam diam. Morbi risus metus, molestie et scelerisque at, cursus.", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non ultrices massa. Nam porttitor ante a sodales tempus. Donec ac aliquam diam. Morbi risus metus, molestie et scelerisque at, cursus."];

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.getTitle),
        backgroundColor: MyApp.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          RecipeTitles(availableHeight: availableHeight, availableWidth: availableWidth, color: MyApp.primaryColor, label: recipe.getTitle),
          Center(
            child: Container(
              width: availableWidth * 0.8,
              height: availableHeight * 0.35,
              padding: EdgeInsets.only( top: availableHeight * 0.02),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                    recipe.getImage, 
                    fit: BoxFit.cover,
          
                  )
              ),
            ),
          ),
          RecipeTitles(availableHeight: availableHeight, availableWidth: availableWidth, color: MyApp.primaryColor, label: "Ingredientes"),
          Column(
            children: 
              ListOfIngredients.map((Ingredient) {
                  return Container(
                    padding: EdgeInsets.only(left: availableWidth * 0.08, right: availableHeight * 0.08, top: availableHeight * 0.01),
                    child: Row(
                      children: [
                        const Text("\u2022", style: TextStyle(fontSize: 15),), 
                        const SizedBox(width: 10,), 
                        Expanded( 
                          child:Text(Ingredient, style: const TextStyle(fontSize: 15),), 
                        )
                      ],
                    ),
                  );
                } ).toList()
          ),
          RecipeTitles(availableHeight: availableHeight, availableWidth: availableWidth, color: MyApp.primaryColor, label: "Como fazer"),
          Column(
            children: 
              ListOfPreparationMethods.map((method) {
                  return Container(
                    padding: EdgeInsets.only(left: availableWidth * 0.08, right: availableHeight * 0.08, top: availableHeight * 0.01),
                    child: Row(
                      children: [
                        const Text("\u2022", style: TextStyle(fontSize: 15),), 
                        const SizedBox(width: 10,), 
                        Expanded( 
                          child:Text(method, style: const TextStyle(fontSize: 15),), 
                        )
                      ],
                    ),
                  );
                } ).toList()
          ),
          Padding(padding: EdgeInsets.only(top: availableHeight * 0.03)),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: MyApp.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              //padding: EdgeInsets.only(top: availableWidth * 0.05),
              width: availableWidth * 0.8,
              height: availableHeight * 0.15,
              child: Column(
                children: [
                  Container(
                  width: availableWidth * 0.75,
                  height: availableHeight * 0.07,
                  padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                       Container(
                        width: availableWidth * 0.3,
                        child: Text(
                          "Serve ${recipe.getNumberOfPortion} pessoas",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        ),
                       Center(
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Preparo: ${recipe.getPreparationTime} minutos",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      )
                      ]
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: availableWidth * 0.01)),
                  Container(
                    child: Text(
                      "Autor: ${recipe.getAuthor} ",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(top: availableWidth * 0.05
        )),
        Center(
          child: defaultButton(
            label: "Ver receitas do mesmo autor", 
            function: (){}, 
            buttonColor: MyApp.primaryColor
          ),
        )
          ],
        ),
      ),
    );
  }
}