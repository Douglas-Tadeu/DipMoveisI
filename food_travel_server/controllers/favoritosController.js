const db = require("../database/db");
const gerarId = require("../utils/gerarId");

function adicionarFavorito(req, res) {
  const { usuarioId, pratoId, restauranteId } = req.body;
  if (!usuarioId || (!pratoId && !restauranteId)) return res.status(400).json({ error: "Dados inválidos" });

  const exists = db.favoritos.find(f => f.usuarioId === usuarioId && f.pratoId === pratoId && f.restauranteId === restauranteId);
  if (exists) return res.json({ message: "Já favoritado" });

  const novo = { id: gerarId("f"), usuarioId, pratoId: pratoId || null, restauranteId: restauranteId || null, dataCriacao: new Date().toISOString() };
  db.favoritos.push(novo);
  res.json(novo);
}

function listarFavoritosDoUsuario(req, res) {
  const { usuarioId } = req.params;
  const favs = db.favoritos.filter(f => f.usuarioId === usuarioId);
  // map para retornar objetos (prato ou restaurante)
  const result = favs.map(f => {
    if (f.pratoId) return { tipo: "prato", item: db.pratos.find(p => p.id === f.pratoId) };
    if (f.restauranteId) return { tipo: "restaurante", item: db.restaurantes.find(r => r.id === f.restauranteId) };
    return null;
  }).filter(Boolean);
  res.json(result);
}

function removerFavorito(req, res) {
  const { id } = req.params;
  const idx = db.favoritos.findIndex(f => f.id === id);
  if (idx === -1) return res.status(404).json({ error: "Favorito não encontrado" });
  db.favoritos.splice(idx, 1);
  res.json({ message: "Removido" });
}

module.exports = { adicionarFavorito, listarFavoritosDoUsuario, removerFavorito };
