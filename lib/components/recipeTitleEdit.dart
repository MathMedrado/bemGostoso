import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';


class RecipeTitleEdit extends StatefulWidget {
  RecipeTitleEdit({super.key, required this.availableHeight, required this.availableWidth, required this.color, required this.label, required this.recipe});

  final double availableHeight;
  final double availableWidth;
  final Color color;
  final String label;
  final Recipe recipe;

  @override
  State<RecipeTitleEdit> createState() => _RecipeTitleEditState();
}

class _RecipeTitleEditState extends State<RecipeTitleEdit> {

  int userId = 0;
  
  setUserId() async {
    int? newUserId = await MyApp.getUserId();

    setState(() {
      userId = newUserId!;
    });
  }

  deleteRecipe(Recipe recipe) async {
    int newRecipeId = recipe.getId;
    Uri url = Uri.parse("${MyApp.baseUrl}/app/recipe/${newRecipeId}/");
    var response = await http.delete(url);
    print(response.statusCode);
    print(response.body);
    print(url);
    if(response.statusCode == 204){
      SnackBar snackbar = SnackBar(content: Text("Sua receita foi excluida com sucesso!", selectionColor: Colors.green,));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.of(context).pushReplacementNamed(MyApp.HOMEPAGE);

    } else {
      SnackBar snackbar = SnackBar(content: Text("ocorreu um erro ao exluir a receita!", selectionColor: Colors.red,));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.of(context).pop();

    }
  }

  editRecipe(Recipe recipe){
    int newRecipeId = recipe.getId;
    Navigator.of(context).pushNamed(MyApp.EDIT_RECIPE_PAGE, arguments: recipe);

  }

  @override
  Widget build(BuildContext context) {
    
    setUserId();  

    return Container(
        padding: EdgeInsets.only(top: widget.availableHeight * 0.02, left: widget.availableWidth * 0.08),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 25,
                    color: widget.color
                  ),
                ),
                
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: widget.availableWidth * 0.5)),
                userId == widget.recipe.getAuthorId ? 
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(widget.color)
                  ),
                  onPressed: (){
                    deleteRecipe(widget.recipe);
                  }, 
                  child: Icon(Icons.delete, color: Colors.white  )) :
                  Container(),
                Padding(padding: EdgeInsets.only(left: widget.availableWidth * 0.02)),
                userId == widget.recipe.getAuthorId ? 
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(widget.color)
                  ),
                  onPressed: (){
                    editRecipe(widget.recipe);
                  }, 
                  child: Icon(Icons.edit_square, color: Colors.white  )) :
                  Container()
              ],
            )
          ],
        ),
      );
  }
}