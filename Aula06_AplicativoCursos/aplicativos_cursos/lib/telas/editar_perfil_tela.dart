import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfilTela extends StatefulWidget {
  const EditarPerfilTela({super.key});

  @override
  State<EditarPerfilTela> createState() => _EditarPerfilTelaState();
}

class _EditarPerfilTelaState extends State<EditarPerfilTela> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  Uint8List? fotoBytesWeb;

  Future<void> escolherDaGaleria() async {
    final XFile? imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem == null) {
      return;
    }

    final bytes = await imagem.readAsBytes();
    setState(() {
      fotoBytesWeb = bytes;
    });
  }

  Future<void> tirarFoto() async {
    final XFile? imagem = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (imagem == null) {
      return;
    }

    final bytes = await imagem.readAsBytes();
    setState(() {
      fotoBytesWeb = bytes;
    });
  }

  void mostrarOpcoesFoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  escolherDaGaleria();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.pop(context);
                  tirarFoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString('nome');
    final email = prefs.getString('email');
    final String? fotoBase64 = prefs.getString('foto_base64');

    if (nome != null) nomeController.text = nome;
    if (email != null) emailController.text = email;

    if (fotoBase64 != null && fotoBase64.isNotEmpty) {
      setState(() {
        fotoBytesWeb = base64Decode(fotoBase64);
      });
    }
  }

  Future<void> salvarPerfil() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o nome e o e-mail')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('nome', nome);
    await prefs.setString('email', email);

    if (fotoBytesWeb != null) {
      final String base64String = base64Encode(fotoBytesWeb!);
      await prefs.setString('foto_base64', base64String);
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil salvo com sucesso'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    carregarPerfil();
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imagemProvedor;
    if (fotoBytesWeb != null) {
      imagemProvedor = MemoryImage(fotoBytesWeb!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: imagemProvedor,
                    child: imagemProvedor == null ? const Icon(Icons.person, size: 70) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        onPressed: mostrarOpcoesFoto,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: salvarPerfil,
                  icon: const Icon(Icons.save, color: Colors.black),
                  label: const Text(
                    'Salvar alterações',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}