const usuarios = [
  // usuario de teste (senha: 123456)
  { id: "u1", nome: "Douglas", email: "douglas@example.com", senhaHash: "$2a$10$7GZKkqR3kYkQ1/6jZQeUO.8jJz3Z5f0WzQZ1sGxJY0xwR1JmEJYbG", fotoPerfil: null }
];

const restaurantes = [
  { id: "r1", nome: "Restaurante do Chef", endereco: "Rua Principal, 100", telefone: "65 99999-0000", imagemUrl: "" },
  { id: "r2", nome: "Sabor & Arte", endereco: "Avenida Brasil, 455", telefone: "65 98888-1111", imagemUrl: "" }
];

const pratos = [
  { id: "p1", restauranteId: "r1", nome: "Lasanha Especial", descricao: "Lasanha caseira com molho artesanal", imagemUrl: "", preco: 29.9 },
  { id: "p2", restauranteId: "r1", nome: "Pizza de Calabresa", descricao: "Pizza com borda recheada", imagemUrl: "", preco: 39.9 },
  { id: "p3", restauranteId: "r2", nome: "Strogonoff Tradicional", descricao: "Strogonoff com batata palha", imagemUrl: "", preco: 25.0 }
];

const favoritos = [
  // { id: 'f1', usuarioId: 'u1', pratoId: 'p1', restauranteId: null, dataCriacao: '...' }
];

const avaliacoes = [
  // { id: 'a1', usuarioId: 'u1', pratoId: 'p1', nota: 4.5, comentario: 'Ótimo!', data: '...' }
];

module.exports = {
  usuarios,
  restaurantes,
  pratos,
  favoritos,
  avaliacoes
};
