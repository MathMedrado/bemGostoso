import 'package:bemgostoso/components/bigInputArea.dart';
import 'package:bemgostoso/components/defaultInputFromField.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/Ingredients.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../components/defaultInputField.dart';

class RegistryRecipe extends StatefulWidget {
  const RegistryRecipe({super.key});

  @override
  State<RegistryRecipe> createState() => _RegistryRecipeState();
}

class _RegistryRecipeState extends State<RegistryRecipe> {



  final titleController = TextEditingController();
  final preparationTimeController = TextEditingController();
  final numberOfPortionsController = TextEditingController();
  final preparationMethodController = TextEditingController();
  final ingredientsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String recipeTittle = "";
  String preparationTime = "";
  String numberOfPortions = "";
  String preparationMethod = "";
  List<String> listOfIngredients = [];



  void _addIngredientToList() {
    setState(() {
      print(ingredientsController.text);
      listOfIngredients.add(ingredientsController.text); // Add value to the list
      ingredientsController.clear(); // Clear the TextFormField
    });
  }

  photoFunction() async {

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

  
  
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: availableHeight * 0.01, bottom: availableHeight * 0.01)),
              DefaultInputFormField(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Digite o titulo da sua receita", 
              label: "Titulo", textController: titleController, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.01, 
              keyboardType: TextInputType.name, 
              //initialValue: recipeTittle,
              onSaved: (String? value){
                print(value);
              }, 
            ),
            DefaultInputFormField(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Informe o tempo de preparo", 
              label: "Tempo de preparo", textController: preparationTimeController, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              //initialValue: preparationTime,
              onSaved: (String? value){
                print(value);
              }, 
            ),
            DefaultInputFormField(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Informe o número de porções", 
              label: "Número de porções", textController: numberOfPortionsController, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              //initialValue: numberOfPortions,
              onSaved: (String? value){
                print(value);
              }, 
            ),
            BigInputArea(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Informe o método de preparo da receita", 
              label: "Método de preparo", textController: preparationMethodController, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, initialValue: preparationMethod,
              onSaved: (String? value){
                print(value);
              }, 
            ),
            DefaultInputFormField(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Adicione o número de porções", 
              label: "Número de porções", textController: numberOfPortionsController, 
              validateFunc: (){}, 
              paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              //initialValue: numberOfPortions,
              onSaved: (String? value){
                print(value);
              }, 
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: availableWidth* 0.055, top: availableHeight * 0.02),
                  child: DefaultInputField(
                    BorderColor: MyApp.primaryColor, 
                    definedWidth: availableWidth * 0.75, 
                    hintText: "Adicione um ingrediente", 
                    label: "Ingrediente", 
                    textController: ingredientsController, 
                    validateFunc: (){},
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 5, right: 5)),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyApp.primaryColor, // Set the border color
                      width: 2.0, // Set the border width
                    ),
                  ),
                  child: IconButton(
                    onPressed: _addIngredientToList, 
                    icon: const Icon(
                      Icons.add,
                      color: MyApp.primaryColor,
                    )
                  ),
                )
              ],
            ),
            listOfIngredients.isNotEmpty ?
            Column(
              children: [
                Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOfIngredients.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(listOfIngredients[index]),
                              IconButton(
                                onPressed: (){
                                  listOfIngredients.remove(listOfIngredients[index]);
                                  setState(() {
                                    listOfIngredients = listOfIngredients;
                                  });
                                }, 
                                icon: Icon(Icons.delete)
                              )
                            ],
                          )
                        ]
                      );
                    },
                  ),
                )
              ],
            ) 
            : Container(),
            Container(
              child: const Text("Adicione uma foto da receita"),
            ),
            ElevatedButton(
              child: const Text("Adicionar"),
              onPressed: photoFunction
            )
          ],
        ),
      ),
    );
  }
}