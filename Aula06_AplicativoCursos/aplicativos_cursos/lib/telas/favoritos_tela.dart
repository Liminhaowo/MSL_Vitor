import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget {
  final List<String> cursosFavoritados;

  const FavoritosPage({super.key, required this.cursosFavoritados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cursosFavoritados.isEmpty
          ? const Center(
              child: Text('Nenhum curso favoritado ainda.'),
            )
          : Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                    itemCount: cursosFavoritados.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.play_arrow),
                          ),
                          title: Row(
                            children: [
                              const Icon(Icons.flutter_dash_outlined),
                              const SizedBox(width: 4),
                              Text(cursosFavoritados[index]),
                            ],
                          ),
                          subtitle: const Text('Curso salvo nos favoritos'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
    );
  }
}