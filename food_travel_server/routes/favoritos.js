const express = require("express");
const router = express.Router();
const ctrl = require("../controllers/favoritosController");
const { authMiddleware } = require("../middlewares/authMiddleware");

router.post("/", authMiddleware, ctrl.adicionarFavorito);
router.get("/:usuarioId", authMiddleware, ctrl.listarFavoritosDoUsuario);
router.delete("/:id", authMiddleware, ctrl.removerFavorito);

module.exports = router;
