import 'dart:convert';

import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/Ingredients.dart';
import 'package:bemgostoso/models/recipe.dart';
import 'package:flutter/material.dart';
import '../components/recipePortrait.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;


class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {

  @override
  void initState() {
    getCategory();
    getAllRecipes();
  }

  bool isLoading = true;
  List<Category> listOfCategory = [];
  // List<Category> listOfCategory = [
  //   Category(id: 1, name: "Bolos", image: "lib/assets/images/cake.png"),
  //   Category(id: 2, name: "Salgados", image: "lib/assets/images/cake.png")

  // ];

  List<Recipe> listOfRecipes = [];
  // List<Recipe> listOfRecipes = [
  //   Recipe(id: 1, title: "Bolinho", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  //   Recipe(id: 2, title: "Bolinho de açuçar", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  //   Recipe(id: 3, title: "Torta", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  //   Recipe(id: 4, title: "Torta 2", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  //   Recipe(id: 5, title: "Torta 3", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  // ];

  getCategory() async {
    List<Category> allListOfCategory = [];

    Uri url = Uri.parse("${MyApp.baseUrl}/app/category/");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body); 
      print(data);
      data.forEach(
        (element) {
          allListOfCategory.add(Category(id: element["id"], name: element["name"], image: element["icon"]));
        }
      );

      setState(() {
        listOfCategory = allListOfCategory;
      });

    }
  }

  getAllRecipes() async {
    List<Recipe>newRecipes = [];
    Uri url = Uri.parse("${MyApp.baseUrl}/app/recipe/");
    var response = await http.get(url);
    print(response.body);
    if(response.statusCode == 200){
    var data = jsonDecode(response.body); 
      print(data);
      data.forEach(
        (element) {
          List<String> newListingredients = [];
          newListingredients = MyApp.manipulationListIngredient(element["ingredient"]);
          newRecipes.add(Recipe(id: element["id"], title: element["title"], authorId: element["user"]["id"], preparationMethod: element["preparation_method"], numberOfPortion: element["number_of_portion"], author: element["user"]["username"], categoryId: element["category"]["id"], categoryName: element["category"]["name"], preparationTime: "${element["preparation_time"]}", image: element["recipe_image"], Ingredients: newListingredients));
        }
      );

      setState(() {
        listOfRecipes= newRecipes;
        isLoading = false;
      });
    }
  }

  sendToCategoryPage(int id) async {
    List<Recipe> listOfRecipeCategory = [];
    Uri url = Uri.parse("${MyApp.baseUrl}/app/recipe?category=${id}");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      data.forEach(
        (element){
          List<String> newListingredients = [];
          newListingredients = MyApp.manipulationListIngredient(element["ingredient"]);
          listOfRecipeCategory.add(Recipe(id: element["id"], title: element["title"], authorId: element["user"]["id"], preparationMethod: element["preparation_method"], numberOfPortion: element["number_of_portion"], author: element["user"]["username"], categoryId: element["category"]["id"], categoryName: element["category"]["name"], preparationTime: "${element["preparation_time"]}", image: element["recipe_image"], Ingredients: newListingredients));
        }
      );
      Navigator.of(context).pushNamed(MyApp.CATEGORY_PAGE, arguments: listOfRecipeCategory);
    }
  }



  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    //getUserInfo();

    return isLoading ?
    const Center(
      child: CircularProgressIndicator(),
    )
    :
    SingleChildScrollView(
      
      child: Column(
        children: [
          Center(
            child: Container(
              height: availableHeight * 0.1,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), 
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listOfCategory.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          sendToCategoryPage(listOfCategory[index].getId);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: availableWidth * 0.01, top: 0.01),
                          width: availableWidth * 0.07,
                          height: availableHeight * 0.07,
                          child: Image.network(listOfCategory[index].getImage)
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: availableWidth * 0.02, top: 0.01),
                        child: Text(
                          listOfCategory[index].getName,
                          style: TextStyle(
                            fontSize: 12
                          ),
                        )
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
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
    );
  }
}