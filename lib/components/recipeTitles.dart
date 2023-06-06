import 'package:flutter/material.dart';
import '../models/recipe.dart';


class RecipeTitles extends StatelessWidget {
  const RecipeTitles({super.key, required this.availableHeight, required this.availableWidth, required this.color, required this.label});

  final double availableHeight;
  final double availableWidth;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: availableHeight * 0.02, left: availableWidth * 0.08),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 25,
            color: color
          ),
        ),
      );
  }
}