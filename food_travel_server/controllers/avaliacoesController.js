const db = require("../database/db");
const gerarId = require("../utils/gerarId");

function adicionarAvaliacao(req, res) {
  const { usuarioId, pratoId, nota, comentario } = req.body;
  if (!usuarioId || !pratoId || nota === undefined) return res.status(400).json({ error: "Dados inválidos" });

  const novo = { id: gerarId("a"), usuarioId, pratoId, nota: Number(nota), comentario: comentario || "", data: new Date().toISOString() };
  db.avaliacoes.push(novo);
  res.json(novo);
}

function listarAvaliacoesPorPrato(req, res) {
  const { pratoId } = req.params;
  const lista = db.avaliacoes.filter(a => a.pratoId === pratoId);
  res.json(lista);
}

function removerAvaliacao(req, res) {
  const { id } = req.params;
  const idx = db.avaliacoes.findIndex(a => a.id === id);
  if (idx === -1) return res.status(404).json({ error: "Avaliação não encontrada" });
  db.avaliacoes.splice(idx, 1);
  res.json({ message: "Removida" });
}

module.exports = { adicionarAvaliacao, listarAvaliacoesPorPrato, removerAvaliacao };
