import 'package:flutter/material.dart';

class defaultButton extends StatelessWidget {
  defaultButton({ super.key, required this.label, required this.function, required this.buttonColor});
  
  final String label;
  final void Function() function;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      width: availableWidth * 0.5,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(buttonColor),
        ),
        onPressed: function,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
              label,
              style: TextStyle(
                fontSize: 22
              ),
              ),
        )
           ),
    );
  }
}