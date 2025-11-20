const express = require("express");
const router = express.Router();
const usuariosController = require("../controllers/usuariosController");
const { authMiddleware } = require("../middlewares/authMiddleware");

router.get("/", authMiddleware, usuariosController.listarUsuarios);
router.put("/:id", authMiddleware, usuariosController.atualizarUsuario);

module.exports = router;
