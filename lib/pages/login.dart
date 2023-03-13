import 'package:bemgostoso/components/DefaultTextButton.dart';
import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import '../components/defaultInputField.dart';
import '../components/logoWithName.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final primaryColor = Color.fromARGB(1000, 235, 69, 17);
    String email;
    String password;

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


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
              Navigator.pushReplacementNamed(context, MyApp.APPHOME);
            }, 
            buttonColor: primaryColor
          ),
          DefaultTextButton(
            function: (){}, 
            label: "Esqueceu a Senha", 
            buttonColor: primaryColor)
        ],
      ),
    );
  }
}