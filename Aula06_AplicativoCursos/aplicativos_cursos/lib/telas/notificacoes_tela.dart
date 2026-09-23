import 'package:flutter/material.dart';

class NotificacoesTela extends StatelessWidget {
  const NotificacoesTela({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notificacoes = [
      {
        'titulo': 'Novo curso disponível',
        'mensagem': 'O curso de Desenvolvimento Mobile avançado já está no ar!',
        'tempo': 'Há 2 horas',
      },
      {
        'titulo': 'Meta alcançada!',
        'mensagem': 'Parabéns por concluir 16 aulas nesta semana.',
        'tempo': 'Ontem',
      },
      {
        'titulo': 'Atualização de perfil',
        'mensagem': 'Suas informações de perfil foram salvas com sucesso.',
        'tempo': 'Há 3 dias',
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: notificacoes.length,
              itemBuilder: (context, index) {
                final notificacao = notificacoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.notifications),
                    ),
                    title: Text(
                      notificacao['titulo']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(notificacao['mensagem']!),
                        const SizedBox(height: 6),
                        Text(
                          notificacao['tempo']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
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