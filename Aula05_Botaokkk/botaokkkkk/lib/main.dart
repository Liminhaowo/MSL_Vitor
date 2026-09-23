import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indiceAtual = 0;
  final paginas = const [Text('Inicio'), Text('Buscar'), Text('Perfil')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: paginas[indiceAtual]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceAtual,
        onTap: (indice) {
          setState(() {
            indiceAtual = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Ínicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}