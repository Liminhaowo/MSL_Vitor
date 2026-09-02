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
          seedColor: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 174, 0),
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.deepPurple,
          indicatorColor: Color.fromARGB(255, 255, 153, 0),
          iconTheme: WidgetStatePropertyAll(
            IconThemeData(
              color: Colors.white
            )
          ),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color : Colors.white
            )
          )
        )
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

  final telas = const [InicioTela(), CursosTela(), PerfilTela()];
  final titulos = const ['Inicio', 'Meus Cursos', 'Meu Perfil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulos[indice]), centerTitle: true),
      body: telas[indice],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (valor) {
          setState(() {
            indice = valor;
          });
        },
        selectedIndex: indice,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_max_outlined),
            label: 'INICIO',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'CRUSOS',
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

class InicioTela extends StatelessWidget {
  const InicioTela({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Olá Fiote',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        const Text('Continue aprendendo e evoluindo'),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.flutter_dash_sharp, color: Colors.white, size: 46),
              Text(
                'Flutter Basico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '8 a 12 aulas concluidas',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CursosTela extends StatelessWidget {
  const CursosTela({super.key});

  @override
  Widget build(BuildContext context) {
    final cursos = [
      'Flutter Basico',
      'Dart Essencial',
      'Intrface Mobile',
      'Python',
      'DJ',
    ];

    return ListView.builder(
      itemCount: cursos.length,
      itemBuilder: (context, indice) => Card(
        child: ListTile(
          title: Text(cursos[indice]),
          leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
          subtitle: const Text('Toque para continuar'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class PerfilTela extends StatelessWidget {
  const PerfilTela({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 46, child: Icon(Icons.person, size: 52)),
          SizedBox(height: 16),

          Text(
            'Aluno Flutter',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
