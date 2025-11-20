const db = require("../database/db");
const gerarId = require("../utils/gerarId");

function listarRestaurantes(req, res) {
  res.json(db.restaurantes);
}

function buscarRestaurante(req, res) {
  const { id } = req.params;
  const r = db.restaurantes.find(x => x.id === id);
  if (!r) return res.status(404).json({ error: "Restaurante não encontrado" });
  res.json(r);
}

function criarRestaurante(req, res) {
  const { nome, endereco, telefone, imagemUrl } = req.body;
  const novo = { id: gerarId("r"), nome, endereco, telefone, imagemUrl: imagemUrl || "" };
  db.restaurantes.push(novo);
  res.json(novo);
}

function atualizarRestaurante(req, res) {
  const { id } = req.params;
  const r = db.restaurantes.find(x => x.id === id);
  if (!r) return res.status(404).json({ error: "Não encontrado" });
  const { nome, endereco, telefone, imagemUrl } = req.body;
  if (nome) r.nome = nome;
  if (endereco) r.endereco = endereco;
  if (telefone) r.telefone = telefone;
  if (imagemUrl !== undefined) r.imagemUrl = imagemUrl;
  res.json(r);
}

function deletarRestaurante(req, res) {
  const { id } = req.params;
  const idx = db.restaurantes.findIndex(x => x.id === id);
  if (idx === -1) return res.status(404).json({ error: "Não encontrado" });
  db.restaurantes.splice(idx, 1);
  res.json({ message: "Removido" });
}

module.exports = { listarRestaurantes, buscarRestaurante, criarRestaurante, atualizarRestaurante, deletarRestaurante };
