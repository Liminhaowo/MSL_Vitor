import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    const stories = [
      ('Seu Story', Icons.add, Colors.grey),
      ('Carlos Viado', Icons.add, Colors.pink),
      ('Nicolly Santista', Icons.add, Colors.blue),
      ('David Guedes', Icons.add, Colors.yellow),
      ('Ignacio Henrique', Icons.add, Colors.green),
      ('Kelvin Orlando', Icons.add, Colors.orange),
    ];
    return SizedBox(
      height: 112,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, indice) {
          final story = stories[indice];
          return GestureDetector(
            onTap:(){
              mostrarMensagem(context, 'Story de ${story.$1}');
            },
            child: SizedBox(
              width: 78,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: indice == 0 ? [Colors.grey.shade400, Colors.grey.shade400] : [Colors.purple, Colors.pink, Colors.orange])
                    ),
                    child: CircleAvatar(
                    radius: 32,
                    backgroundColor: story.$3,
                    child: Icon(Icons.face_3, color: Colors.white, size: 30),
                  ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story.$1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
