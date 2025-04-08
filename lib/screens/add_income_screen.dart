import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction_data.dart';
import '../models/transaction_model.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController valorController = TextEditingController();
  final TextEditingController fonteController = TextEditingController();
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

  void _salvarReceita() {
    String valorTexto = valorController.text.trim();
    String fonte = fonteController.text.trim();

    if (valorTexto.isEmpty || fonte.isEmpty) {
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
        tipo: 'receita',
        valor: valor,
        descricao: 'Receita adicionada',
        categoria: fonte,
        data: dataSelecionada,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receita adicionada com sucesso!')),
    );

    Navigator.pop(context, true); // Retorna true para atualizar saldo
  }

  @override
  Widget build(BuildContext context) {
    final String dataFormatada = DateFormat('dd/MM/yyyy').format(dataSelecionada);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Adicionar Receita')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.attach_money, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fonteController,
              decoration: const InputDecoration(
                labelText: 'Fonte da Receita',
                prefixIcon: Icon(Icons.work_outline),
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
                onPressed: _salvarReceita,
                icon: const Icon(Icons.check, color: Colors.white,),
                label: const Text('Salvar Receita', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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