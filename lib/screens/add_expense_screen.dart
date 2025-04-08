import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction_data.dart';
import '../models/transaction_model.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController valorController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  DateTime dataSelecionada = DateTime.now();

  void _selecionarData() async {
    final DateTime? novaData = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (novaData != null) {
      setState(() {
        dataSelecionada = novaData;
      });
    }
  }

  void _salvarDespesa() {
    String valorTexto = valorController.text.trim();
    String categoria = categoriaController.text.trim();
    String descricao = descricaoController.text.trim();

    if (valorTexto.isEmpty || categoria.isEmpty || descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    double? valor = double.tryParse(valorTexto.replaceAll(',', '.'));
    if (valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valor inválido')),
      );
      return;
    }

    transacoes.add(
      TransactionModel(
        tipo: 'despesa',
        valor: valor,
        descricao: descricao,
        categoria: categoria,
        data: dataSelecionada,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Despesa adicionada com sucesso!')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final String dataFormatada = DateFormat('dd/MM/yyyy').format(dataSelecionada);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Adicionar Despesa')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Icon(Icons.remove_circle_outline, size: 80, color: Colors.red),
            const SizedBox(height: 24),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoria',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Data: $dataFormatada',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton.icon(
                  onPressed: _selecionarData,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Selecionar Data'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _salvarDespesa,
                icon: const Icon(Icons.check,color: Colors.white,),
                label: const Text('Salvar Despesa', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
}