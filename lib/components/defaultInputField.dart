import 'package:flutter/material.dart';


class DefaultInputField extends StatelessWidget {
  DefaultInputField({
    super.key, 
    required this.textController, 
    required this.validateFunc,
    required this.label,
    required this.hintText,
    required this.definedWidth,
    required this.BorderColor 
      }
    );

  final TextEditingController textController;
  final String? label;
  final String? hintText;
  final Function() validateFunc;
  final double definedWidth;
  final Color BorderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: definedWidth,
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          label: Text(label!),
          labelStyle: TextStyle(color: BorderColor),
          hintText: hintText,
          hintStyle: TextStyle(color: BorderColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: (BorderColor)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(5)),
            borderSide:
                BorderSide(color: (BorderColor),
          ),
        ),
        
      ),
    ));
  }
}