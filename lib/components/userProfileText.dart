import 'package:flutter/material.dart';

class UserProfileText extends StatelessWidget {
  const UserProfileText(
  {
    super.key, 
    required this.label, 
    required this.value, 
    required this.topPadding, 
    required this.leftPadding
  }
  );
  
  final String label;
  final String value;
  final double topPadding;
  final double leftPadding;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: topPadding, left: leftPadding),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: topPadding, left: leftPadding),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16
            ),
          ),
        )
      ],
    );
  }
}