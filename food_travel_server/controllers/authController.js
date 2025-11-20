const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const db = require("../database/db");
const gerarId = require("../utils/gerarId");
const { SECRET } = require("../middlewares/authMiddleware");

async function login(req, res) {
  const { email, senha } = req.body;
  const user = db.usuarios.find(u => u.email === email);
  if (!user) return res.status(401).json({ error: "Usuário não encontrado" });

  const ok = await bcrypt.compare(senha, user.senhaHash);
  if (!ok) return res.status(401).json({ error: "Senha incorreta" });

  const token = jwt.sign({ id: user.id, email: user.email }, SECRET, { expiresIn: "7d" });
  res.json({ token, usuario: { id: user.id, nome: user.nome, email: user.email, fotoPerfil: user.fotoPerfil } });
}

async function register(req, res) {
  const { nome, email, senha } = req.body;
  if (db.usuarios.find(u => u.email === email)) return res.status(400).json({ error: "Email já cadastrado" });

  const salt = await bcrypt.genSalt(10);
  const hash = await bcrypt.hash(senha, salt);
  const novo = { id: gerarId("u"), nome, email, senhaHash: hash, fotoPerfil: null };
  db.usuarios.push(novo);
  const token = jwt.sign({ id: novo.id, email: novo.email }, SECRET, { expiresIn: "7d" });
  res.json({ token, usuario: { id: novo.id, nome: novo.nome, email: novo.email } });
}

module.exports = { login, register };
