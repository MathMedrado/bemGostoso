import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu(
    {
      super.key,
      required this.borderColor,
      required this.dropdownMap,
      required this.value,
      required this.stateFunction,
      required this.availableWidth,
      required this.title
    }
  );

  final Color borderColor;
  final Map<String, String> dropdownMap;
  final String value;
  final String title;
  final double availableWidth;
  final Function(String?) stateFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: availableWidth * 0.01, left: availableWidth * 0.01),
          child: Text(
            title,
            style: TextStyle(
              color: borderColor
            ),
          ),
        ),
        Padding(
              padding:  EdgeInsets.only(left: availableWidth * 0.01, top: availableWidth * 0.02),
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: availableWidth * 0.90,
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor as Color),
                    borderRadius: BorderRadius.circular(5),
                  color: Colors.white
                ),
                child: DropdownButton(
                  value: value.isNotEmpty? value : null,
                  isExpanded: true,
                  focusColor: borderColor ,
                  items:    dropdownMap.entries.map<DropdownMenuItem<String>>((entry){
                    return DropdownMenuItem(
                      value: entry.value as String,
                      child: Text(" ${entry.key}"),
                    );}).toList(),
                    underline: SizedBox(),
                    onChanged:stateFunction,
                  iconEnabledColor: Colors.black,
                ),
              ),
            ),
      ],
    );
  }
}