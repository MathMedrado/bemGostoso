import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BigInputArea extends StatelessWidget {
  BigInputArea(
    {
      super.key,
      required this.BorderColor,
      required this.definedWidth,
      required this.hintText,
      required this.label,
      required this.textController,
      required this.validateFunc,
      required this.paddingLeft,
      required this.paddingTop,
      required this.onSaved,
      required this.keyboardType, 
      required this.initialValue
    });

  final TextEditingController textController;
  final  String? label;
  final String? hintText;
  final Function() validateFunc;
  final double definedWidth;
  final Color BorderColor;
  final double paddingLeft;
  final double paddingTop;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final String initialValue;
  


  @override
  Widget build(BuildContext context) {
    return Container(
      width: definedWidth,
      padding: EdgeInsets.only(left: paddingLeft, top: paddingTop,),
      child: TextFormField(
         //controller: textController,
         onSaved: onSaved,
         initialValue: initialValue,
         keyboardType: keyboardType,
         maxLines: 6,
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
      ),
    );
  }
}