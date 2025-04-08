class TransactionModel {
  final String tipo;
  final double valor;
  final String descricao;
  final String categoria;
  final DateTime data;

  TransactionModel({
    required this.tipo,
    required this.valor,
    required this.descricao,
    required this.categoria,
    required this.data,
  });
}