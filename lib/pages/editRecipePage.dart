import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../components/bigInputArea.dart';
import '../components/defaultButton.dart';
import '../components/defaultInputField.dart';
import '../components/defaultInputFieldWithRecipe.dart';
import '../components/defaultInputFromField.dart';
import '../components/dropdownMenu.dart';
import '../main.dart';
import '../models/category.dart';
import '../models/recipe.dart';

class EditRecipePage extends StatefulWidget {
  const EditRecipePage({super.key});

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {

  @override
  void initState() {
    getCategory();

  }


  final titleController = TextEditingController();
  final preparationTimeController = TextEditingController();
  final numberOfPortionsController = TextEditingController();
  final preparationMethodControllerField = TextEditingController();
  final ingredientsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String recipeTittle = "";
  String preparationTime = "";
  String numberOfPortions = "";
  String preparationMethod = "";
  String categoryName = "";
  List<String> listOfIngredients = [];
  bool isLoading = true;
  List<Category> listOfCategory = [];
  Map<String, String> mapOfCategoryAndId = {};

  void _alteringTheListOfIngredients(List<String> list) {
    setState(() {
      listOfIngredients = list;
    });
  }
    

  void _addIngredientToList() {
    setState(() {
      print(ingredientsController.text);
      listOfIngredients.add(ingredientsController.text); // Add value to the list
      ingredientsController.clear(); // Clear the TextFormField
    });
  }

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
      Map<String, String> newMapOfCategoryAndId = {};
      allListOfCategory.forEach((element) {
        newMapOfCategoryAndId[element.name] = "${element.id}";
      });

      setState(() {
        listOfCategory = allListOfCategory;
        mapOfCategoryAndId = newMapOfCategoryAndId;
        isLoading = false;
      });

    }
  }

  _submitAlteringRecipe(int recipeId) async {
    int? userId = await MyApp.getUserId();
    Uri url = Uri.parse("${MyApp.baseUrl}/app/recipe/${recipeId}/");
    print(numberOfPortions);
    print(preparationTime);
    print(categoryName);
    print(listOfIngredients);
    var response = await http.put(
      url,
      body: {
        "title": recipeTittle,
        "number_of_portion": numberOfPortions,
        "preparation_method": preparationMethod,
        "preparation_time": preparationTime,
        "category": categoryName,
        "user": "$userId",
        "ingredient": "${listOfIngredients}"
      }
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
        const SnackBar snackBar = SnackBar(content: Text("A receita foi alterada com sucesso."), backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushReplacementNamed( MyApp.HOMEPAGE);

    } else {
        const SnackBar snackBar = SnackBar(content: Text("Ocorreu um erro ao alterar a sua  receita, tente novamente mais tarde."), backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    var parameter = ModalRoute.of(context)!.settings.arguments;
    Recipe recipe = parameter as Recipe;
    _alteringTheListOfIngredients(recipe.getIngredients);

    // setState(() {
    //   recipeTittle = recipe.getTitle;
    //   preparationTime = recipe.getPreparationTime;
    //   numberOfPortions = recipe.getNumberOfPortion;
    //   preparationMethod = recipe.getPreparationMethod;
    //   categoryName = recipe.getCategoryName;
    //   listOfIngredients = recipe.getIngredients;
    // });



    return Scaffold(
      appBar: AppBar(title: Text(" Alteração da receita ${recipe.getTitle}"), backgroundColor: MyApp.primaryColor,),
      body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: availableHeight * 0.01, bottom: availableHeight * 0.01)),
              DefaultInputFormFieldWithRecipe(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Digite o titulo da sua receita", 
              label: "Titulo", 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.01, 
              keyboardType: TextInputType.name, 
              initialValue: recipe.getTitle,
              onSaved: (String? value){
                recipeTittle =  value!;
                print(value);
              }, 
            ),
            DefaultInputFormFieldWithRecipe(
              BorderColor: MyApp.primaryColor, 
              definedWidth: availableWidth * 0.9, 
              hintText: "Informe o tempo de preparo", 
              label: "Tempo de preparo", 
              //textController: preparationTimeController, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              initialValue: recipe.getPreparationTime,
              onSaved: (String? value){
                preparationTime = value!;
                print(value);
              }, 
            ),
            BigInputArea(BorderColor: MyApp.primaryColor, definedWidth: availableWidth * 0.9, hintText: "Informe o método de preparo da receita", 
              label: "Método de preparo", textController: preparationMethodControllerField, 
              validateFunc: (){}, paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              onSaved: (String? value){
                setState(() {
                  preparationMethod = preparationMethodControllerField.text;
                  print(value);
                });
              }, 
            ),
            CustomDropdownMenu(
              title: "Categoria",
              borderColor: MyApp.primaryColor,
              availableWidth: availableWidth,
              dropdownMap: mapOfCategoryAndId,
              stateFunction: (String? value){
                categoryName = value!;
              },
              value: categoryName,
            ),
            DefaultInputFormFieldWithRecipe(
              BorderColor: MyApp.primaryColor, 
              definedWidth: availableWidth * 0.9, 
              hintText: "Adicione o número de porções", 
              label: "Número de porções",  
              validateFunc: (){}, 
              paddingLeft: availableWidth* 0.01, 
              paddingTop: availableHeight * 0.02, 
              keyboardType: TextInputType.name, 
              initialValue: recipe.getNumberOfPortion,
              onSaved: (String? value){
                setState(() {
                  numberOfPortions = value!;
                  print(value);
                });
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
            defaultButton(
              label: "Alterar receita", 
              function: (){
                if (_formKey.currentState!.validate()) {
                   _formKey.currentState!.save();
                   _submitAlteringRecipe(recipe.getId);
                }
              }, 
              buttonColor: MyApp.primaryColor
            )
          ],
        ),
      ),
    ),
    );
  }
}