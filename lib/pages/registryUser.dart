import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/defaultInputField.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';

class RegistryUser extends StatefulWidget {
  const RegistryUser({super.key});

  @override
  State<RegistryUser> createState() => _RegistryUserState();
}

class _RegistryUserState extends State<RegistryUser> {
  
  final nameController = TextEditingController();
  String fullName = "";
  final emailController = TextEditingController();
  String email = "";
  final passController = TextEditingController();
  String password1 = "";
  final pass2Controller = TextEditingController();
  String password2 = "";
  final telController = TextEditingController();
  String phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submitForm(String fullName, String email, String password, String phone,  ) async {
    // print(fullName);
    // print(email);
    // print(password);
    // print(phone);
    Uri url = Uri.parse("${MyApp.baseUrl}/user");
    var response = await http.post(
      url, 
      body: {
        "userName": fullName,
        "email": email,
        "tel": phone,
        "password": password,
        "birthDate": "2023-02-27T19:32:00.009495",
        "perfilImage": "imagem1"
      },
      headers: {
          "content_type": "application/json",
          "charset" : "utf-8"
      }
    );
    print(response.statusCode);
    print(response.body);

  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de usuário"),
        backgroundColor: MyApp.primaryColor,
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: availableHeight * 0.03,
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,
                    keyboardType: TextInputType.text,
                    hintText: "Digite o seu nome completo",
                    label: "Nome Completo",
                    textController: nameController,
                    //initialValue: "",
                    validateFunc: (){},
                    onSaved: (value){
                      fullName = value!;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,
                    keyboardType: TextInputType.emailAddress,                    
                    hintText: "Digite o seu email",
                    label: "Email",
                    textController: emailController,
                    //initialValue: "",
                    validateFunc: (){},
                    onSaved: (value){
                      email = value!;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Digite o seu telefone",
                    label: "Telefone",
                    keyboardType: TextInputType.number,
                    //initialValue: "",
                    textController: telController,
                    validateFunc: (){},
                    onSaved: (value){
                      phone = value!;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Digite  a sua senha",
                    //initialValue: "",
                    label: "Senha",
                    keyboardType: TextInputType.text,
                    textController: passController,
                    validateFunc: (){},
                    onSaved: (value){
                      password1 = value!;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Repita a sua senha",
                    label: "Senha",
                    keyboardType: TextInputType.text,
                    textController: pass2Controller,
                    validateFunc: (){},
                    //initialValue: "",
                    onSaved: (value){
                      password2 = value!;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButtonRow(
                        label: "Cadastrar", 
                        function: (){
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            password1 = passController.text;
                            password2 = pass2Controller.text;
                            if(password1 == password2){
                              fullName = nameController.text;
                              email = emailController.text;
                              phone = telController.text;
                              submitForm(fullName, email, password1, phone);
                              
                            }
                          }
                        }, 
                      buttonColor: MyApp.primaryColor),
                      SizedBox(
                        width: availableWidth * 0.05,
                      ),
                      defaultButtonRow(
                        label: "Cancelar", 
                        function: (){
                          Navigator.of(context).pop();
                        }, 
                        buttonColor: MyApp.primaryColor)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}