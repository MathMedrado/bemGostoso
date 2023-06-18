import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import '../components/defaultButton.dart';
import '../components/logoWithName.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: availableHeight * 0.2,
          ),
          Center(
            child: Column(
              children: [
                  const LogoWithName(),
                  defaultButton(
                    label: "Entrar", 
                    function: (){
                      Navigator.pushNamed(context, MyApp.LOGIN);
                    }, 
                    buttonColor: MyApp.primaryColor
                  ),
                  defaultButton(
                    label: "Cadastro", 
                    function: (){
                      Navigator.pushNamed(context, MyApp.REGISTER);
                    }, 
                    buttonColor: MyApp.primaryColor
                  ),
              ],
            ),
            )
        ],
      ),
    );
  }
}