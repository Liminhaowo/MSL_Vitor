import 'package:flutter/material.dart';
import '../dados_mock.dart';
import '../services/api_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  bool esconderSenha = true;
  bool esconderConfirmacao = true;

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  Future<void> cadastrar() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      mostrarMensagem('Preencha todos os campos corretamente');
      return;
    }

    if (!email.contains('@')) {
      mostrarMensagem('Digite seu e-mail válido');
      return;
    }

    if (senha.length < 4) {
      mostrarMensagem('A senha deve ter 4 elementos.');
      return;
    }

    if (senha != confirmarSenha) {
      mostrarMensagem('A senha não são iguais.');
      return;
    }

    bool emailExiste = false;

    for (var usuario in usuarios) {
      if (usuario['email'] == email) {
        emailExiste = true;
        break;
      }
    }

    if (emailExiste) {
      mostrarMensagem('Já existe parsa');
      return;
    }

    //usuarios.add({'nome': nome, 'email': email, 'senha': senha});

    final resultado = await ApiService.cadastrar(
      nome: nome,
      email: email,
      senha: senha,
    );

    if (resultado['sucesso'] = true) {
      mostrarMensagem('Usuario cadastrado');
      Navigator.pop(context);
      return;
    }

    mostrarMensagem('Usuario Cadastrador menó');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar usuario'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.person_add, size: 90),

            const SizedBox(height: 15),

            const Text(
              'Criar conta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu Nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu E-mail',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua Senha',
                prefixIcon: const Icon(Icons.block),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmarSenhaController,
              obscureText: esconderConfirmacao,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                hintText: 'Digite sua Senha Novamente',
                prefixIcon: Icon(Icons.lock_clock_outlined),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderConfirmacao = !esconderConfirmacao;
                    });
                  },
                  icon: Icon(
                    esconderConfirmacao
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: cadastrar,
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('Cadastrar', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar para o Login'),
            ),
          ],
        ),
      ),
    );
  }
}
