import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/recipe.dart';
import 'package:flutter/material.dart';
import '../components/recipePortrait.dart';
import '../models/category.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<Category> listOfCategory = [
    Category(id: 1, name: "Bolos", image: "lib/assets/images/cake.png"),
    Category(id: 2, name: "Salgados", image: "lib/assets/images/cake.png")

  ];

  List<Recipe> listOfRecipes = [
    Recipe(id: 1, title: "Bolinho", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
    Recipe(id: 2, title: "Bolinho de açuçar", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
    Recipe(id: 3, title: "Torta", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
    Recipe(id: 4, title: "Torta 2", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
    Recipe(id: 5, title: "Torta 3", description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png"),
  ];

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return SingleChildScrollView(
      
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
                      Container(
                        padding: EdgeInsets.only(left: availableWidth * 0.01, top: 0.01),
                        width: availableWidth * 0.07,
                        height: availableHeight * 0.07,
                        child: Image.asset(listOfCategory[index].getImage)
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