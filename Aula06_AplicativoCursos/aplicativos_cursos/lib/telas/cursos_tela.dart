import 'package:flutter/material.dart';

class CursosTela extends StatefulWidget {
  const CursosTela({super.key});

  @override
  State<CursosTela> createState() => _CursosTelaState();
}

class _CursosTelaState extends State<CursosTela> {
  final cursos = [
    'Flutter Basico',
    'Dart Essencial',
    'Interface Mobile',
    'Python',
    'DJ',
    'Culinaria',
  ];

  final descricao = [
    'Curso que se vai fazer flutter \n80H de duração',
    'Curso que se vai fazer dart \n70H de duração',
    'Curso que se vai fazer interface \n30H de duração',
    'Curso que se vai fazer python \n50H de duração',
    'Curso que se vai dijeiar \n20H de duração',
    'Curso que se vai cozinhar \n140H de duração',
  ];

  final icones = [
    Icon(Icons.flutter_dash_outlined),
    Icon(Icons.bluetooth),
    Icon(Icons.mobile_friendly),
    Icon(Icons.code),
    Icon(Icons.music_note),
    Icon(Icons.food_bank),
  ];

  final corDosCirculos = [
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.orange,
    Colors.grey,
    Colors.redAccent,
  ];

  String resultado = '';

  @override
  Widget build(BuildContext context) {
    // Filtra os cursos usando where()
    final cursosFiltrados = cursos.where((curso) {
      return curso.toLowerCase().contains(resultado.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar curso...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            ),
            
            // 2. Trava a mesma borda para quando NÃO estiver clicado
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            ),
            
            // 3. Trava a mesma MERDA de borda para quando ESTIVER clicado (ignora o azul do Flutter)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            ),
            ),
            onChanged: (valor) {
              setState(() {
                resultado = valor;
              });
            },
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: cursosFiltrados.length,
            itemBuilder: (context, indice) {
              // Descobre o índice original do curso
              final indiceOriginal = cursos.indexOf(
                cursosFiltrados[indice],
              );

              return Card(
                child: ListTile(
                  title: Text(cursosFiltrados[indice]),
                  leading: CircleAvatar(
                    backgroundColor: corDosCirculos[indiceOriginal],
                    child: icones[indiceOriginal],
                  ),
                  subtitle: Text(
                    descricao[indiceOriginal],
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}