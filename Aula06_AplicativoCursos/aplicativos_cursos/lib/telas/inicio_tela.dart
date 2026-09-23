import 'package:aplicativos_cursos/widgets/secoesCard.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'Olá, estudante!',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Continue aprendendo e evoluindo'),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SecoesCard(
              quantidade: '4',
              subtitulo: 'Cursos iniciados'
            ),
            SizedBox(width: 12),
            SecoesCard(
              quantidade: '1',
              subtitulo: 'Cursos concluídos'
            ),
            SizedBox(width: 12),
            SecoesCard(
              quantidade: '18',
              subtitulo: 'Aulas concluídas'
            ),
          ],
        ),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 0, 27, 177), const Color.fromARGB(255, 0, 150, 209)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.flutter_dash, color: Colors.white, size: 46),
              Text(
                'Flutter Básico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '8 de 12 aulas concluídas',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}