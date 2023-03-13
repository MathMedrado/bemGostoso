import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/defaultInputField.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';
import '../models/user.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key});


  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  
  
  late String fullName;
  late String email;
  final Controller = TextEditingController();
  late int phone;
  late String password1;
  late String password2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    User user = (parameter == null) ? User( id: 0, username: "", perfilImage: "", email: "", password: "", phone: "", birthDate: DateTime.now()) : parameter as User;

    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar dados"),
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
                    textController: Controller,
                    initialValue: user.getUsername as String,
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
                    initialValue: user.getEmail as String,
                    label: "Email",
                    textController: Controller,
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
                    initialValue: user.getPhone as String,
                    textController: Controller,
                    validateFunc: (){},
                    onSaved: (value){
                      phone = value as int;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButtonRow(
                        label: "Salvar", 
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