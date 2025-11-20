class Restaurante {
  final String id;
  final String nome;
  final String endereco;
  final String imageUrl;

  Restaurante({
    required this.id,
    required this.nome,
    required this.endereco,
    this.imageUrl = '',
  });
}
