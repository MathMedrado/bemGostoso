import 'dart:convert';

import 'package:bemgostoso/components/DefaultTextButton.dart';
import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import '../components/defaultInputField.dart';
import '../components/logoWithName.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final primaryColor = Color.fromARGB(1000, 235, 69, 17);
    String email = "";
    String password = "";

    setEmailState(){
      setState(() {
        email = emailController.text;
      });
    }

    setPasswordState(){
      setState(() {
        email = emailController.text;
      });
    }

    submitLogin(String email, String password) async {
      Uri url = Uri.parse("${MyApp.baseUrl}/user/auth");
      print(url);
      print(email);
      print(password);
      var response = await http.post(
        url, 
        body: {
          "email" : email,
          "password" : password
        },
        headers: {
           "content_type": "application/json",
           "charset" : "utf-8"
        }
      );
      //var data  = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);


    }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: availableHeight * 0.2,
            ),
            const Center(
              child: LogoWithName(),
            ),
            DefaultInputField(
              hintText: "Digite o seu email",
              label: "Email",
              textController: emailController,
              definedWidth: availableWidth * 0.8,
              BorderColor: primaryColor,
              validateFunc: () {},
            ),
            DefaultInputField(
              hintText: "Digite  a sua senha",
              label: "senha",
              textController: passwordController,
              definedWidth: availableWidth * 0.8,
              BorderColor: primaryColor,
              validateFunc: () {},
            ),
            defaultButton(
              label: "Entrar", 
              function: (){
                submitLogin(emailController.text, passwordController.text);
              } ,
              // (){
              //   Navigator.pushReplacementNamed(context, MyApp.APPHOME);
              // }, 
              buttonColor: primaryColor
            ),
            DefaultTextButton(
              function: (){}, 
              label: "Esqueceu a Senha", 
              buttonColor: primaryColor)
          ],
        ),
      ),
    );
  }
}