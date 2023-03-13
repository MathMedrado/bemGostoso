import 'package:flutter/material.dart';

import '../main.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex, required this.func});

  final Function() func;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: MyApp.primaryColor,
        currentIndex: currentIndex,
        onTap: (index) => {
        },
        items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.white,
                  Icons.home,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.white,
                  Icons.add, 
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.white,
                  Icons.person, 
                ),
                label: '',
              ),
          ],
      );
  }
}