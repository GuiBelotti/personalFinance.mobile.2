import 'package:flutter/material.dart';
import '../data/user_data.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  void _cadastrar() {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty || confirmarSenha.isEmpty) {
      _mostrarSnackBar('Preencha todos os campos');
      return;
    }

    if (!email.contains('@')) {
      _mostrarSnackBar('E-mail inválido');
      return;
    }

    if (senha.length < 8 || !senha.contains(RegExp(r'[0-9]')) || !senha.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      _mostrarSnackBar('A senha deve ter no mínimo 8 caracteres, incluir pelo menos 1 número e 1 caractere especial.');
      return;
    }

    if (senha != confirmarSenha) {
      _mostrarSnackBar('As senhas não coincidem');
      return;
    }

    usuarios.add(UserModel(
      nome: nome,
      email: email,
      senha: senha,
    ));

    _mostrarSnackBar('Cadastro realizado com sucesso!', cor: Colors.green);
    Navigator.pop(context);
  }

  void _mostrarSnackBar(String mensagem, {Color cor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: cor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _campoTexto(
              controller: nomeController,
              label: 'Nome',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _campoTexto(
              controller: emailController,
              label: 'E-mail',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _campoTexto(
              controller: senhaController,
              label: 'Senha',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'A senha deve conter no mínimo 8 caracteres,\n1 número e 1 caractere especial.',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            _campoTexto(
              controller: confirmarSenhaController,
              label: 'Confirmar Senha',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _cadastrar,
                icon: const Icon(Icons.check, color: Colors.white,),
                label: const Text('Cadastrar', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
