import 'package:flutter/material.dart';

class CursoPage extends StatefulWidget {
  final List<String> cursos;
  final List<String> descricao;
  final List<bool> favoritos;
  final List<double> progresso;
  final Function(int) onFavoritoChanged;
  final Function(int, double)? onProgressoChanged;

  const CursoPage({
    super.key,
    required this.cursos,
    required this.descricao,
    required this.favoritos,
    required this.progresso,
    required this.onFavoritoChanged,
    this.onProgressoChanged,
  });

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    final cursosFiltrados = widget.cursos.where((curso) {
      return curso.toLowerCase().contains(resultado.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar curso...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                resultado = value;
              });
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: cursosFiltrados.length,
              itemBuilder: (context, indice) {
                final indiceOriginal = widget.cursos.indexOf(
                  cursosFiltrados[indice],
                );
                
                final int aulasConcluidas = (widget.progresso[indiceOriginal] * 12).round();
                final String textoAulas = '$aulasConcluidas/12 aulas';
                
                final String descricaoOriginal = widget.descricao[indiceOriginal];
                final String descricaoModificada = descricaoOriginal.replaceFirst(RegExp(r'\d+ aulas'), textoAulas);

                return Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                const Icon(Icons.flutter_dash_outlined),
                                const SizedBox(width: 4),
                                Text(cursosFiltrados[indice]),
                              ],
                            ),
                            leading: const CircleAvatar(
                              child: Icon(Icons.play_arrow),
                            ),
                            subtitle: Text(descricaoModificada),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: Icon(
                              widget.favoritos[indiceOriginal]
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 24,
                              color: widget.favoritos[indiceOriginal]
                                  ? const Color.fromARGB(255, 202, 13, 0)
                                  : Colors.black,
                            ),
                            onPressed: () {
                              widget.onFavoritoChanged(indiceOriginal);
                            },
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: LinearProgressIndicator(
                            value: widget.progresso[indiceOriginal],
                            backgroundColor: const Color.fromARGB(255, 138, 228, 255),
                            color: const Color.fromARGB(255, 0, 33, 221),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
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