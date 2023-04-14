import 'package:bemgostoso/main.dart';
import 'package:bemgostoso/models/user.dart';
import 'package:bemgostoso/pages/recipePage.dart';
import 'package:bemgostoso/pages/registryRecipe.dart';
import 'package:bemgostoso/pages/userProfile.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    final availableWidth = mediaQuery.size.width;
    User user = User(id: 1, username: "Matheus Medrado", perfilImage: "lib/assets/images/user.png", email: "matheus-13-@hotmail.com", password: "123456789", birthDate: DateTime.now(), phone: "(62) 985287539");

    final AppBarDetails = [
      "Bem Gostoso",
      "Cadastro de receitas",
      "Perfil do usuário"
    ];

    final screens = [ 
      RecipesPage(),
      RegistryRecipe(),
      UserProfile(user: user,),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppBarDetails[currentIndex])),
        backgroundColor: MyApp.primaryColor,
        actions: [
          Icon(Icons.search)
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyApp.primaryColor,
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() { currentIndex = index;})
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
      ),
    );
  }
}