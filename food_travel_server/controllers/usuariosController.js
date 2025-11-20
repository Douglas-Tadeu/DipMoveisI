const db = require("../database/db");
const gerarId = require("../utils/gerarId");
const bcrypt = require("bcryptjs");

function listarUsuarios(req, res) {
  const users = db.usuarios.map(u => ({ id: u.id, nome: u.nome, email: u.email, fotoPerfil: u.fotoPerfil }));
  res.json(users);
}

async function atualizarUsuario(req, res) {
  const { id } = req.params;
  const { nome, email, senha } = req.body;
  const user = db.usuarios.find(u => u.id === id);
  if (!user) return res.status(404).json({ error: "Usuário não encontrado" });

  if (nome) user.nome = nome;
  if (email) user.email = email;
  if (senha) {
    const salt = await bcrypt.genSalt(10);
    user.senhaHash = await bcrypt.hash(senha, salt);
  }
  res.json({ message: "Atualizado", usuario: { id: user.id, nome: user.nome, email: user.email, fotoPerfil: user.fotoPerfil } });
}

module.exports = { listarUsuarios, atualizarUsuario };
