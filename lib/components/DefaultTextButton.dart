import 'package:bemgostoso/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

class DefaultTextButton extends StatelessWidget {
  DefaultTextButton({super.key, required this.function, required this.label, required this.buttonColor});

  Function() function;
  String label;
  Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: function,
        child: Text(
          label,
          style: TextStyle(
            color: buttonColor
          ),
        ),
      ),
    );
  }
}