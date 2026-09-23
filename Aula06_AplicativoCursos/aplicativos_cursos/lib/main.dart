import 'package:aplicativos_cursos/telas/cursos_tela.dart';
import 'package:aplicativos_cursos/telas/favoritos_tela.dart';
import 'package:aplicativos_cursos/telas/inicio_tela.dart';
import 'package:aplicativos_cursos/telas/notificacoes_tela.dart';
import 'package:aplicativos_cursos/telas/perfil_tela.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue
        ),
        scaffoldBackgroundColor: const Color(
          0xFFF5F3FA
        ),
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.blue,
          indicatorColor: Colors.white24,
          iconTheme: WidgetStatePropertyAll(
            IconThemeData(
              color: Colors.white
            ),
          ),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Colors.white
            )
          )
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int indice = 0;
  
  final List<String> cursos = [
    'Flutter Básico',
    'Dart Essencial',
    'Interface Mobile',
    'Conexão API',
    'Banco de Dados',
    'Desenvolvimento Mobile',
  ];

  final List<String> descricao = [
    'Curso introdutório sobre desenvolvimento mobile utilizando Flutter\n12 aulas\nContinuar curso',
    'Curso essencial sobre os fundamentos de lógica de programção em Dart\nDart Essencial\n12 aulas\nContinuar curso',
    'Venha aprender UI/UX em um curso introdutório ao assunto\nInterface Mobile\n12 aulas\nContinuar curso',
    'Venha aprender a conectar o seu backend com seu frontend nesse curso de Java\nConexão API\n12 aulas\nIniciar curso',
    'Curso de API eba\nConexão API\n12 aulas\nIniciar curso',
    'Curso pra conectar a API eba\nConexão API\n12 aulas\nIniciar curso',
  ];

  late final List<bool> favoritos = List.filled(cursos.length, false);
  late final List<double> progresso = [0.10, 0.40, 0.80, 0.0, 0.0, 0.0];

  final titulos = [
    'Home',
    'Meus Cursos',
    'Meus Favoritos',
    'Notificações',
    'Meu Perfil',
  ];

  @override
  Widget build(BuildContext context){
    List<String> listaFavoritos = [];
    for (int i = 0; i < cursos.length; i++) {
      if (favoritos[i]) {
        listaFavoritos.add(cursos[i]);
      }
    }

    final telas = [
      const InicioPage(),
      CursoPage(
        cursos: cursos,
        descricao: descricao,
        favoritos: favoritos,
        progresso: progresso,
        onFavoritoChanged: (index) {
          setState(() {
            favoritos[index] = !favoritos[index];
          });
        },
      ),
      FavoritosPage(cursosFavoritados: listaFavoritos),
      const NotificacoesTela(),
      const PerfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titulos[indice]
        ),
      ),
      body: telas[indice],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (valor){
          setState(() {
            indice = valor;
          });
        },
        selectedIndex: indice,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'Cursos'
          ),
          NavigationDestination(
            icon: Icon(Icons.star_outline),
            label: 'Favoritos'
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notificações'
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil'
          ),
        ],
      ),
    );
  }
}