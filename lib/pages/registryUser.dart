import 'package:bemgostoso/components/defaultButton.dart';
import 'package:bemgostoso/components/defaultInputField.dart';
import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';
import '../components/defaultButtonRow.dart';
import '../components/defaultInputFromField.dart';

class RegistryUser extends StatefulWidget {
  const RegistryUser({super.key});

  @override
  State<RegistryUser> createState() => _RegistryUserState();
}

class _RegistryUserState extends State<RegistryUser> {
  
  final nameController = TextEditingController();
  String fullName = "";
  final emailController = TextEditingController();
  String email = "";
  final passController = TextEditingController();
  String password1 = "";
  final pass2Controller = TextEditingController();
  String password2 = "";
  final telController = TextEditingController();
  String phone = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String birthdate = "";

  submitForm(String fullName, String email, String password, String phone,  ) async {
    print(fullName);
    print(email);
    print(password);
    print(phone);
    Uri url = Uri.parse("${MyApp.baseUrl}/user/create");
    var response = await http.post(
      url, 
      body: {
        "username": fullName,
        "email": email,
        "telephone": phone,
        "password": password,
        "birth_date": birthdate,
      },
      headers: {
          "content_type": "application/json",
          "charset" : "utf-8"
      }
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 201){
      const SnackBar snackBar = SnackBar(content: Text("Usuário cadastrado com sucesso."), backgroundColor: Colors.green,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      
    } else {
      const SnackBar snackBar = SnackBar(content: Text("Ocorreu um erro, tente novamente mais tarde."), backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    var maskData = MaskTextInputFormatter(mask: '##/##/####');

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de usuário"),
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
                    textController: nameController,
                    //initialValue: "",
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
                    label: "Email",
                    textController: emailController,
                    //initialValue: "",
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
                    //initialValue: "",
                    textController: telController,
                    validateFunc: (){},
                    onSaved: (value){
                      phone = value!;
                    },
                  ),
                   Padding(
                      padding: EdgeInsets.only(left: availableWidth * 0.01, top:  availableWidth* 0.04),
                      child: Container(
                        width: availableWidth * 0.92,
                        child: TextFormField(
                          validator: Validatorless.multiple([
                            Validatorless.required(
                                "Data de Nascimento Obrigatória"),
                          ]),
                          onSaved: (newValue) => birthdate =
                              newValue!.split('/').reversed.join("-"),
                          initialValue: maskData.maskText(birthdate
                              .toString()
                              .split('-')
                              .reversed
                              .join("")),
                          cursorColor: Colors.green[900],
                          inputFormatters: [maskData],
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'Data de Nascimento',
                            hintText: '',
                            hintStyle: TextStyle(color: MyApp.primaryColor),
                            labelStyle: TextStyle(color: MyApp.primaryColor),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: (MyApp.primaryColor)!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: (MyApp.primaryColor)!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // DefaultInputFormField(
                  //   BorderColor: MyApp.primaryColor,
                  //   definedWidth: availableWidth * 0.92,
                  //   paddingLeft: availableWidth * 0.01,
                  //   paddingTop: availableWidth* 0.04,                    
                  //   hintText: "Digite a sua data de nascimento",
                  //   label: "Data de nascimento",
                  //   keyboardType: TextInputType.number,
                  //   //initialValue: "",
                  //   textController: telController,
                  //   validateFunc: (){},
                  //   onSaved: (value){
                  //     phone = value!;
                  //   },
                  // ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Digite  a sua senha",
                    //initialValue: "",
                    label: "Senha",
                    keyboardType: TextInputType.text,
                    textController: passController,
                    validateFunc: (){},
                    onSaved: (value){
                      password1 = value!;
                    },
                  ),
                  DefaultInputFormField(
                    BorderColor: MyApp.primaryColor,
                    definedWidth: availableWidth * 0.92,
                    paddingLeft: availableWidth * 0.01,
                    paddingTop: availableWidth* 0.04,                    
                    hintText: "Repita a sua senha",
                    label: "Senha",
                    keyboardType: TextInputType.text,
                    textController: pass2Controller,
                    validateFunc: (){},
                    //initialValue: "",
                    onSaved: (value){
                      password2 = value!;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButtonRow(
                        label: "Cadastrar", 
                        function: (){
                          
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            password1 = passController.text;
                            password2 = pass2Controller.text;
                            if(password1 == password2){
                              fullName = nameController.text;
                              email = emailController.text;
                              phone = telController.text;
                              submitForm(fullName, email, password1, phone);
                              print("hello");
                              
                            }
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