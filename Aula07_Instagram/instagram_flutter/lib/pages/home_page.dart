import 'package:flutter/material.dart';
import 'package:instagram_flutter/pages/buscar_page.dart';
import 'package:instagram_flutter/pages/feed_page.dart';
import 'package:instagram_flutter/pages/perfil_page.dart';
import 'package:instagram_flutter/pages/reels_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indiceAtual = 0;

  final List<Widget> telas = const [
    FeedPage(),
    BuscarPage(),
    ReelsPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: IndexedStack(index: indiceAtual, children: telas),
      bottomNavigationBar: NavigationBar(
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: Colors.deepPurpleAccent,
        selectedIndex: indiceAtual,
        onDestinationSelected: (novoIndice) {
          setState(() {
            indiceAtual = novoIndice;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, size: 30, color: Colors.orangeAccent),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, size: 30, color: Colors.orangeAccent),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie, size: 30, color: Colors.orangeAccent),
            label: 'Reels',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, size: 30, color: Colors.orangeAccent),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
