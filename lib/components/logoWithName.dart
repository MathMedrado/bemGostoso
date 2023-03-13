import 'package:flutter/material.dart';

class LogoWithName extends StatelessWidget {
  const LogoWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            child: Image.asset("lib/assets/images/logo.png")
            ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Bem Gostoso", 
              style: TextStyle(
                color: Colors.orange[800],
                fontSize: 25,
                fontWeight: FontWeight.bold
                ),
              ),
        )
        ],
      ),
    );
  }
}