import 'dart:math';

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
      title: 'Calculadora de Média Escolar',
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      home: MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget {
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => _MediaEscolarPageState();
}

class _MediaEscolarPageState extends State<MediaEscolarPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();
  final TextEditingController nota4Controller = TextEditingController();
  final TextEditingController menorNotaController = TextEditingController();
  final TextEditingController maiorNotaController = TextEditingController();
  final TextEditingController pontosNecessariosController =
      TextEditingController();
  final TextEditingController frequenciaController = TextEditingController();

  String nomeAluno = '';
  String situacao = ''; //aprovado, recuperação, reprovado
  double media = 0;
  double menorNota = 0;
  double maiorNota = 0;
  double pontosNecessarios = 0;
  double frequencia = 0;

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void limparCampos() {
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();
    menorNotaController.clear();
    maiorNotaController.clear();
    pontosNecessariosController.clear();
    frequenciaController.clear();

    setState(() {
      nomeAluno = '';
      media = 0;
      situacao = '';
      menorNota = 0;
      maiorNota = 0;
      pontosNecessarios = 0;
      frequencia = 0;
    });
  }

  IconData escolherIcone() {
    if (situacao == "APROVADO") {
      return Icons.check_circle;
    }
    if (situacao == "RECUPERAÇÃO") {
      return Icons.warning;
    }
    return Icons.cancel;
  }

  Color escolherColor() {
    if (situacao == "APROVADO") {
      return const Color.fromARGB(255, 17, 173, 0);
    }
    if (situacao == "RECUPERAÇÃO") {
      return const Color.fromARGB(255, 216, 195, 0);
    }
    return const Color.fromARGB(255, 225, 0, 0);
  }

  void calcularMedia() {
    String nome = nomeController.text.trim();

    double? nota1 = double.tryParse(nota1Controller.text.replaceAll(',', '.'));
    double? nota2 = double.tryParse(nota2Controller.text.replaceAll(',', '.'));
    double? nota3 = double.tryParse(nota3Controller.text.replaceAll(',', '.'));
    double? nota4 = double.tryParse(nota4Controller.text.replaceAll(',', '.'));
    double? frequencia = double.tryParse(
      frequenciaController.text.replaceAll(',', '.'),
    );

    if (nome.isEmpty ||
        nota1 == null ||
        nota2 == null ||
        nota3 == null ||
        nota4 == null ||
        frequencia == null) {
      mostrarMensagem('Preencha todos os campos corretamente');
      return;
    }

    if (nota1 < 0 ||
        nota1 > 10 ||
        nota2 < 0 ||
        nota2 > 10 ||
        nota3 < 0 ||
        nota3 > 10 ||
        nota4 < 0 ||
        nota4 > 10) {
      mostrarMensagem('As notas devem estar entre 0 e 10');
      return;
    }

    if (frequencia < 0 || frequencia > 100) {
      mostrarMensagem('A frequência deve estar entre 0% e 100%');
      return;
    }

    final List<double> listaNotas = [nota1, nota2, nota3, nota4];
    final int quantidade = listaNotas.length;
    double menorNotaCalculada = listaNotas.reduce(min);
    double maiorNotaCalculada = listaNotas.reduce(max);

    double soma = listaNotas.reduce((a, b) => a + b);
    double mediaCalculada = soma / quantidade;

    double pontosNecessariosCalculado;

    if (mediaCalculada < 7) {
      pontosNecessarios = 7;
      pontosNecessariosCalculado = pontosNecessarios - mediaCalculada;
    } else {
      pontosNecessariosCalculado = 0;
    }

    String situacaoCalculada;

    if (frequencia < 75) {
      if (mediaCalculada < 5) {
        situacaoCalculada = 'REPROVADO POR FREQUÊNCIA\nE POR NOTA';
      } else {
        situacaoCalculada = 'REPROVADO POR FREQUÊNCIA';
      }
    } else if (mediaCalculada >= 7) {
      situacaoCalculada = 'APROVADO';
    } else if (mediaCalculada >= 5) {
      situacaoCalculada = 'RECUPERAÇÃO';
    } else {
      situacaoCalculada = 'REPROVADO POR NOTA';
    }

    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      situacao = situacaoCalculada;
      menorNota = menorNotaCalculada;
      maiorNota = maiorNotaCalculada;
      pontosNecessarios = pontosNecessariosCalculado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculador de Média Escolar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.school,
              size: 80,
              color: Color.fromARGB(255, 0, 34, 255),
            ),
            const SizedBox(height: 10),

            const Text(
              'MÉDIA ESCOLAR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            const Text(
              'Digite o nome e as quatro notas do aluno',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do aluno',
                hintText: '   Ex: Lavínia Chaves de Melos Rodrigo das Virgens',
                prefix: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nota1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nota2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nota3Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: nota4Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 4',
                hintText: 'Digite uma nota de 0 a 10',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: frequenciaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Frequência',
                hintText: 'Digite a frequência de 0% a 100%',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: calcularMedia,
              icon: const Icon(Icons.calculate, color: Colors.black),
              label: const Text(
                'Calcular Média',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: limparCampos,
              icon: const Icon(Icons.delete, color: Colors.black),
              label: const Text(
                'Detetetizar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 25),
            if (situacao.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(escolherIcone(), size: 60, color: escolherColor(),),
                      const SizedBox(height: 10),
                      Text(
                        nomeAluno,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Média: ${media.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        situacao,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Menor nota: ${menorNota.toStringAsFixed(1)}\n'
                        'Maior nota: ${maiorNota.toStringAsFixed(1)}\n'
                        'Pontos necessários para aprovação: ${pontosNecessarios.toStringAsFixed(1)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
