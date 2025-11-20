class Prato {
  final String id;
  final String restauranteId;
  final String nome;
  final String descricao;
  final double preco;
  final String imageUrl;

  Prato({
    required this.id,
    required this.restauranteId,
    required this.nome,
    required this.descricao,
    required this.preco,
    this.imageUrl = '',
  });
}
