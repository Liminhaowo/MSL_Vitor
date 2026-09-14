import 'package:flutter/material.dart';

class FavoritosTela extends StatelessWidget {
  const FavoritosTela({super.key});


  @override
  Widget build(BuildContext context) {
    final cursos = [
      'Flutter Basico',
      'Dart Essencial',
      'Intrface Mobile',
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