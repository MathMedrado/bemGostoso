import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:bemgostoso/models/recipe.dart';


class AppBarSearch extends StatefulWidget {
  const AppBarSearch({required this.title, super.key});
  
  final String title;

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {

 
  final searchText = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return AppBarWithSearchSwitch(
      fieldHintText: 'Buscar por receita',
      clearSearchIcon: Icons.backspace_outlined,

      backgroundColor:  MyApp.primaryColor,
      onChanged: (text){
        searchText.value = text;
        print(text);
      },
      onSubmitted: (text) {
         searchText.value = text;
         print(text);
         //final Recipe recipe =  Recipe(id: 1, title: text, description: "Bolinho", preparationMethod: "Bolinho", numberOfPortion: "1", author: "João sem braço", categoryId: "Bolinho", preparationTime: "10", image: "lib/assets/images/torta.png", Ingredients: []);
         //Navigator.pushNamed(context, MyApp.SEARCH_PAGE, arguments: recipe);

      },
      appBarBuilder: (context) {
          return AppBar(
            // automaticallyImplyLeading: false, Onde quiser retirar o botão da navBar Clica aqui
            backgroundColor: MyApp.primaryColor,
            title: Center(
              child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20
                  ),
                ),
            ),
            actions:  const [
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
    );
  }
}