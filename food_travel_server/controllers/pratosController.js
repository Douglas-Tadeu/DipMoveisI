const db = require("../database/db");
const gerarId = require("../utils/gerarId");

function listarPratosPorRestaurante(req, res) {
  const { restauranteId } = req.params;
  const lista = db.pratos.filter(p => p.restauranteId === restauranteId);
  res.json(lista);
}

function buscarPrato(req, res) {
  const { id } = req.params;
  const p = db.pratos.find(x => x.id === id);
  if (!p) return res.status(404).json({ error: "Prato não encontrado" });
  res.json(p);
}

function criarPrato(req, res) {
  const { restauranteId, nome, descricao, preco, imagemUrl } = req.body;
  const novo = { id: gerarId("p"), restauranteId, nome, descricao, preco: Number(preco || 0), imagemUrl: imagemUrl || "" };
  db.pratos.push(novo);
  res.json(novo);
}

function atualizarPrato(req, res) {
  const { id } = req.params;
  const p = db.pratos.find(x => x.id === id);
  if (!p) return res.status(404).json({ error: "Prato não encontrado" });
  const { nome, descricao, preco, imagemUrl } = req.body;
  if (nome) p.nome = nome;
  if (descricao) p.descricao = descricao;
  if (preco !== undefined) p.preco = Number(preco);
  if (imagemUrl !== undefined) p.imagemUrl = imagemUrl;
  res.json(p);
}

function deletarPrato(req, res) {
  const { id } = req.params;
  const idx = db.pratos.findIndex(x => x.id === id);
  if (idx === -1) return res.status(404).json({ error: "Não encontrado" });
  db.pratos.splice(idx, 1);
  res.json({ message: "Removido" });
}

module.exports = { listarPratosPorRestaurante, buscarPrato, criarPrato, atualizarPrato, deletarPrato };
