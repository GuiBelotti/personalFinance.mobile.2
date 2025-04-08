import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/transaction_data.dart';
import '../models/transaction_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double saldo = 0;

  @override
  void initState() {
    super.initState();
    _calcularSaldo();
  }

  void _calcularSaldo() {
    double total = 0;
    for (var t in transacoes) {
      if (t.tipo == 'receita') {
        total += t.valor;
      } else if (t.tipo == 'despesa') {
        total -= t.valor;
      }
    }
    setState(() {
      saldo = total;
    });
  }

  void _navegarPara(String rota) {
    Navigator.pushNamed(context, rota).then((resultado) {
      if (resultado == true) {
        _calcularSaldo(); // Atualiza o saldo ao voltar
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Minhas Finanças'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre',
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.teal.shade50,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, size: 48, color: Colors.teal),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Saldo Atual', style: TextStyle(fontSize: 18)),
                        Text(
                          formatador.format(saldo),
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: saldo >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCard(
                    icon: Icons.remove_circle_outline,
                    label: 'Adicionar\nDespesa',
                    route: '/add-expense',
                    color: Colors.redAccent,
                  ),
                  _buildCard(
                    icon: Icons.add_circle_outline,
                    label: 'Adicionar\nReceita',
                    route: '/add-income',
                    color: Colors.green,
                  ),
                  _buildCard(
                    icon: Icons.list_alt,
                    label: 'Transações',
                    route: '/transactions',
                    color: Colors.blue,
                  ),
                  _buildCard(
                    icon: Icons.pie_chart_outline,
                    label: 'Relatório',
                    route: '/report',
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String label,
    required String route,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _navegarPara(route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}