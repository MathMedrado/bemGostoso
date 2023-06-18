import 'dart:convert';

import 'package:bemgostoso/components/DefaultTextButton.dart';
import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import '../components/defaultInputField.dart';
import '../components/logoWithName.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      Uri url = Uri.parse("${MyApp.baseUrl}/login/");
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
           "Accept" : "application/json",
           "charset" : "utf-8"
        }
      );
      print(response.body);
      print(response.statusCode);

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("email", email);
        sharedPreferences.setString("password", password);
        sharedPreferences.setInt("userId", data["userId"]);

        Navigator.pushReplacementNamed(context,  MyApp.HOMEPAGE);

      } else{
        const SnackBar snackBar = SnackBar(content: Text("email ou senha estão incorretos."), backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
              function: (){
                Navigator.of(context).pushNamed(MyApp.FORGET_PASSWORD);
              }, 
              label: "Esqueceu a Senha", 
              buttonColor: primaryColor)
          ],
        ),
      ),
    );
  }
}