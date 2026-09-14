import 'package:flutter/material.dart';
import 'package:aplicativos_cursos/telas/inicio_tela.dart';
import 'package:aplicativos_cursos/telas/cursos_tela.dart';
import 'package:aplicativos_cursos/telas/perfil_tela.dart';
import 'package:aplicativos_cursos/telas/favoritos_tela.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 174, 0),
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.deepPurple,
          indicatorColor: Color.fromARGB(255, 255, 153, 0),
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white),
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indice = 0;

  final telas = [InicioTela(), CursosTela(), FavoritosTela(), PerfilTela()];
  final titulos = ['Inicio', 'Meus Cursos','Favoritos', 'Meu Perfil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulos[indice]), titleTextStyle: TextStyle(color: Colors.white, fontSize: 25), centerTitle: true, backgroundColor: Colors.deepPurple,),
      body: telas[indice],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (valor) {
          setState(() {
            indice = valor;
          });
        },
        selectedIndex: indice,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_max_outlined),
            label: 'INICIO',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'CURSOS',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'FAVORITOS',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: 'PERFIS',
          ),
        ],
      ),
    );
  }
}
