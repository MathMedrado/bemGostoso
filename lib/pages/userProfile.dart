import 'dart:convert';

import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/userProfileText.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key, });
  

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  bool isLoading = true;
  late User user;

  startValues() {
    User newUser;
    getUserInfo().then((value) => {
      newUser = value,
      setState(() {
        user = newUser;
        isLoading = false;
      })
    });


  }

Future<User> getUserInfo() async {
    int? userId = await MyApp.getUserId();
    String auth = await MyApp.getBasicAuthentication();


    Uri url = Uri.parse("${MyApp.baseUrl}/user/$userId");
    var response = await http.get(url, headers: <String, String> {
      'authorization' : auth
    });
    
    print(response.statusCode);
    print(response.body);

    var data = jsonDecode(response.body);
    User user = User(id: data["id"], email: data["email"], username: data["username"], birthDate: DateTime.tryParse(data["birth_date"]) , phone: data["telephone"], perfilImage: "", password: data["password"]);
    
    return user;
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).pushReplacementNamed(MyApp.APPHOME);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    if(isLoading == true){
      startValues();   
    } 

    return isLoading? 
    const Center(
      child: CircularProgressIndicator(),
    )
    : 
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: availableHeight * 0.02),
              height: availableHeight * 0.2,
              width: availableWidth * 0.5,
              child: Image.asset("lib/assets/images/user.png" as String),
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
          ),
          Container(
            padding: EdgeInsets.only(left: availableWidth * 0.03),
            child: defaultButton(label: "Sair", function: () => logout(), buttonColor: MyApp.primaryColor)
          )
    
        ],
      ),
    );
  }
}