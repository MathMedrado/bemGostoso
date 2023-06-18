import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/defaultInputField.dart';
import 'package:bemgostoso/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';
import '../models/user.dart';

class ExcludProfile extends StatefulWidget {
  ExcludProfile({super.key});


  @override
  State<ExcludProfile> createState() => _ExcludProfileState();
}

class _ExcludProfileState extends State<ExcludProfile> {
  
  
  late String username;
  late String email;
  final userController = TextEditingController();
  final passController = TextEditingController();
  late String password1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submitExcludeUser() async {
    int? userId = await MyApp.getUserId();
    Uri url = Uri.parse("${MyApp.baseUrl}/user/$userId/");
    var response = await http.delete(url);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 204){
      const SnackBar snackBar = SnackBar(content: Text("Usuário removido com sucesso."), backgroundColor: Colors.green,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context).pushNamed(MyApp.APPHOME);

    } else {
      const SnackBar snackBar = SnackBar(content: Text("Ocorreu um erro, ao excluir a sua conta."), backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    var parameter = ModalRoute.of(context)!.settings.arguments;
    User user = (parameter == null) ? User( id: 0, username: "", perfilImage: "", email: "", password: "", phone: "", birthDate: DateTime.now()) : parameter as User;

    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Exclusão de conta"),
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
                    hintText: "Digite o seu email",
                    label: "Email",
                    textController: userController,
                    //initialValue: user.getUsername as String,
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
                    keyboardType: TextInputType.emailAddress,                    
                    hintText: "Digite a sua senha",
                    //initialValue: "",
                    label: "senha",
                    textController: passController,
                    validateFunc: (){},
                    onSaved: (value){
                      password1 = value!;
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
                          print(email);
                          submitExcludeUser();
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