import 'dart:convert';

import 'package:bemgostoso/components/appBarSearch.dart';
import 'package:bemgostoso/components/recipeTitles.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:bemgostoso/models/Ingredients.dart';
import 'package:http/http.dart' as http;

import '../components/defaultButton.dart';
import '../components/recipeTitleEdit.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({super.key});
  
  sendToAuthorPage(int id, context) async {
    List<Recipe> listOfRecipeAuthor = [];
    Uri url = Uri.parse("${MyApp.baseUrl}/app/recipe?user=${id}");
    var response = await http.get(url);
    print(response.body);
    print(id);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      data.forEach(
        (element){
          List<String> newListingredients = [];
          newListingredients = MyApp.manipulationListIngredient(element["ingredient"]);
          listOfRecipeAuthor.add(Recipe(id: element["id"], title: element["title"], authorId: element["user"]["id"], preparationMethod: element["preparation_method"], numberOfPortion: element["number_of_portion"], author: element["user"]["username"], categoryId: element["category"]["id"], categoryName: element["category"]["name"], preparationTime: "${element["preparation_time"]}", image: element["recipe_image"], Ingredients: newListingredients));
        }
      );
      Navigator.of(context).pushNamed(MyApp.AUTHOR_PAGE, arguments: listOfRecipeAuthor);
    }
  }

  @override
  Widget build(BuildContext context) {

    var parameter = ModalRoute.of(context)!.settings.arguments;
    Recipe recipe = parameter as Recipe;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    final List<String> ListOfPreparationMethods = [recipe.getPreparationMethod];

    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarSearch(title: recipe.getTitle)
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          RecipeTitleEdit(availableHeight: availableHeight, availableWidth: availableWidth, color: MyApp.primaryColor, label: recipe.getTitle, recipe: recipe),
          Center(
            child: Container(
              width: availableWidth * 0.8,
              height: availableHeight * 0.35,
              padding: EdgeInsets.only( top: availableHeight * 0.02),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                    recipe.getImage, 
                    fit: BoxFit.cover,
          
                  )
              ),
            ),
          ),
          RecipeTitles(availableHeight: availableHeight, availableWidth: availableWidth, color: MyApp.primaryColor, label: "Ingredientes"),
          Column(
            children: 
              recipe.Ingredients.map((Ingredient) {
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
            function: (){
              print(recipe.getAuthorId);
              sendToAuthorPage(recipe.getAuthorId, context);
            }, 
            buttonColor: MyApp.primaryColor
          ),
        )
          ],
        ),
      ),
    );
  }
}