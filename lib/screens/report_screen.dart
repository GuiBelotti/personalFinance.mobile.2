import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction_data.dart';
import '../models/transaction_model.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  Map<String, double> _calcularTotaisPorCategoria(String tipo) {
    final Map<String, double> totais = {};
    for (var t in transacoes) {
      if (t.tipo == tipo) {
        totais[t.categoria] = (totais[t.categoria] ?? 0) + t.valor;
      }
    }
    return totais;
  }

  @override
  Widget build(BuildContext context) {
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final despesas = _calcularTotaisPorCategoria('despesa');
    final receitas = _calcularTotaisPorCategoria('receita');

    final totalDespesas = despesas.values.fold(0.0, (a, b) => a + b);
    final totalReceitas = receitas.values.fold(0.0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: const Text('Relatório por Categoria')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Despesas por Categoria',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Total de despesas: ${formatador.format(totalDespesas)}',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 8),
            despesas.isEmpty
                ? const Text('Nenhuma despesa registrada.')
                : Column(
              children: despesas.entries.map((entry) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_upward, color: Colors.red),
                    title: Text(entry.key),
                    trailing: Text(
                      formatador.format(entry.value),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Receitas por Categoria',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Total de receitas: ${formatador.format(totalReceitas)}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 8),
            receitas.isEmpty
                ? const Text('Nenhuma receita registrada.')
                : Column(
              children: receitas.entries.map((entry) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text(entry.key),
                    trailing: Text(
                      formatador.format(entry.value),
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}