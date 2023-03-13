import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/userProfileText.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/user.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key, required this.user});
  
  final User user;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: availableHeight * 0.02),
              height: availableHeight * 0.2,
              width: availableWidth * 0.5,
              child: Image.asset(user.getPerfilImage as String),
            ),
          ),
          UserProfileText(
            label: "Nome", 
            value: user.getUsername as String,
            topPadding: availableHeight * 0.01,
            leftPadding: availableWidth * 0.03,
          ),
          SizedBox(height: availableHeight * 0.02,),
          UserProfileText(
            label: "Email", 
            value: user.getEmail as String,
            topPadding: availableHeight * 0.01,
            leftPadding: availableWidth * 0.03,
          ),
          SizedBox(height: availableHeight * 0.02,),
          UserProfileText(
            label: "Telefone", 
            value: user.getPhone as String,
            topPadding: availableHeight * 0.01,
            leftPadding: availableWidth * 0.03,
          ),
          SizedBox(height: availableHeight * 0.02,),
          UserProfileText(
            label: "Data de Nascimento", 
            value: "${user.getBirthDate}",
            topPadding: availableHeight * 0.01,
            leftPadding: availableWidth * 0.03,
          ),
          SizedBox(height: availableHeight * 0.04,),
          Container(
            padding: EdgeInsets.only(left: availableWidth * 0.03),
            child: defaultButton(label: "Alterar dados", function: () => Navigator.of(context).pushNamed(MyApp.EDITUSER, arguments: user), buttonColor: MyApp.primaryColor)
            ),
          Container(
            padding: EdgeInsets.only(left: availableWidth * 0.03),
            child: defaultButton(label: "Excluir conta", function: () => Navigator.of(context).pushNamed(MyApp.EXCLUDPROFILE, arguments: user), buttonColor: MyApp.primaryColor)
          )
    
        ],
      ),
    );
  }
}