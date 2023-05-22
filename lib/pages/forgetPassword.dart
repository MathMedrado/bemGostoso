import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  
  String username = "";
  late String email = "";
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperação de senha"),
        backgroundColor: MyApp.primaryColor,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: availableHeight * 0.03,
                    ),
                    DefaultInputFormField(
                      BorderColor: MyApp.primaryColor,
                      definedWidth: availableWidth * 0.92,
                      paddingLeft: availableWidth * 0.05,
                      paddingTop: availableWidth* 0.04,
                      keyboardType: TextInputType.text,
                      hintText: "Digite o seu nome completo",
                      label: "Nome Completo",
                      textController: usernameController,
                      //initialValue: user.getUsername as String,
                      validateFunc: (){},
                      onSaved: (value){
                        username = value!;
                      },
                    ),
                    DefaultInputFormField(
                      BorderColor: MyApp.primaryColor,
                      definedWidth: availableWidth * 0.92,
                      paddingLeft: availableWidth * 0.05,
                      paddingTop: availableWidth* 0.04,
                      keyboardType: TextInputType.text,
                      hintText: "Digite o seu email",
                      label: "Email",
                      textController: emailController,
                      //initialValue: user.getUsername as String,
                      validateFunc: (){},
                      onSaved: (value){
                        email = value!;
                      },
                    ),
                    SizedBox(
                      height: availableHeight * 0.02,
                    ),
                    defaultButtonRow(
                        label: "  Enviar  ", 
                        function: () async {
                          if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                            print(username);
                            print(email);
                            String? auth = await MyApp.getBasicAuthentication();
                            Uri url = Uri.parse("${MyApp.baseUrl}/user/reset_password");
                            var response = await http.post(
                                url, 
                                headers: <String, String> { 'authorization' : auth },
                                body: {
                                  "email" : email,
                                  "username" : username
                                }
                              );
                              print(response.statusCode);
                              print(response.body);
                          }
                        }, 
                        buttonColor: MyApp.primaryColor
                      ),
                ],
              )
            )
        ],
      ),
    );
  }
}