import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction_data.dart';
import '../models/transaction_model.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  void _confirmarExclusao(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir transação'),
        content: const Text('Tem certeza que deseja excluir esta transação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                transacoes.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transação excluída')),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatadorData = DateFormat('dd/MM/yyyy');
    final formatadorValor = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: AppBar(title: const Text('Transações')),
      body: transacoes.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma transação cadastrada.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: transacoes.length,
        itemBuilder: (context, index) {
          final transacao = transacoes[index];
          final cor = transacao.tipo == 'receita' ? Colors.green : Colors.red;
          final icone = transacao.tipo == 'receita'
              ? Icons.arrow_downward
              : Icons.arrow_upward;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: cor.withOpacity(0.1),
                child: Icon(icone, color: cor),
              ),
              title: Text(
                transacao.descricao,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${transacao.categoria} • ${formatadorData.format(transacao.data)}',
              ),
              trailing: Text(
                formatadorValor.format(transacao.valor),
                style: TextStyle(
                  color: cor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onLongPress: () => _confirmarExclusao(index),
            ),
          );
        },
      ),
    );
  }
}