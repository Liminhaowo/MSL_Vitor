import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';

class PostInstagram extends StatefulWidget {
  final String usuario;
  final String local;
  final String legenda;
  final Color cor;
  final IconData icone;
  final int curtidasInicias;

  const PostInstagram({
    super.key,
    required this.usuario,
    required this.local,
    required this.legenda,
    required this.cor,
    required this.curtidasInicias,
    required this.icone,
  });

  @override
  State<PostInstagram> createState() => _PostInstagramState();
}

class _PostInstagramState extends State<PostInstagram> {
  bool curtiu = false;
  bool salvou = false;

  void alternarCurtida() {
    setState(() {
      curtiu = !curtiu;
    });
  }

  void alternarSalvamento() {
    setState(() {
      salvou = !salvou;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalCurtidas = widget.curtidasInicias + (curtiu ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.cor,
            child: Icon(widget.icone, color: Colors.white),
          ),
          title: Text(
            widget.usuario,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.local),
          trailing: IconButton(
            onPressed: () {
              mostrarMensagem(context, 'Opções da Publicação');
            },
            icon: Icon(Icons.more_horiz),
          ),
        ),
        GestureDetector(
          onDoubleTap: alternarCurtida,
          child: Container(
            height: 330,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [widget.cor, widget.cor.withValues(alpha: 0.55)]
              )
            ),
            child: Icon(widget.icone, color: Colors.white, size: 130),
          ),
        )
      ],
    );
  }
}
