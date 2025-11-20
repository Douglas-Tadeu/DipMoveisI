const jwt = require("jsonwebtoken");
const SECRET = "segredo_super_secreto_foodtravel"; // em prod use env var

function authMiddleware(req, res, next) {
  const header = req.headers["authorization"];
  if (!header) return res.status(401).json({ error: "Token não informado" });
  const parts = header.split(" ");
  if (parts.length !== 2) return res.status(401).json({ error: "Token inválido" });

  const token = parts[1];
  try {
    const payload = jwt.verify(token, SECRET);
    req.usuario = payload; // { id, email }
    next();
  } catch (err) {
    return res.status(401).json({ error: "Token inválido" });
  }
}

module.exports = { authMiddleware, SECRET };
