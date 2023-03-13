import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/defaultInputField.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';

class RegistryUser extends StatefulWidget {
  const RegistryUser({super.key});

  @override
  State<RegistryUser> createState() => _RegistryUserState();
}

class _RegistryUserState extends State<RegistryUser> {
  
  final nameController = TextEditingController();
  late String fullName;
  final emailController = TextEditingController();
  late String email;
  final Controller = TextEditingController();
  late int phone;
  late String password1;
  late String password2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
                    initialValue: "",
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
                    initialValue: "",
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
                    initialValue: "",
                    textController: Controller,
                    validateFunc: (){},
                    onSaved: (value){
                      phone = value as int;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Digite  a sua senha",
                    initialValue: "",
                    label: "Senha",
                    keyboardType: TextInputType.text,
                    textController: Controller,
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
                    textController: Controller,
                    validateFunc: (){},
                    initialValue: "",
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
                          print(fullName);
                          print(email);
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