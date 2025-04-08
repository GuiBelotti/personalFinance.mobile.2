import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Sobre o App'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.teal),
            SizedBox(height: 24),
            Text(
              'Personal Finance 360',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Objetivo do Aplicativo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Este aplicativo tem como objetivo ajudar o usuário a controlar suas finanças pessoais, registrando receitas e despesas, visualizando o saldo atual e acompanhando os gastos por categoria.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),
            Text(
              'Desenvolvedores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '• Guilherme Belotti Machado Luiz\n• Gabriel Carvalheiro Ruela\n• Maria Carolina de Souza',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}