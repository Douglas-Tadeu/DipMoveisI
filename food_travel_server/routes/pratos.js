const express = require("express");
const router = express.Router();
const ctrl = require("../controllers/pratosController");
const { authMiddleware } = require("../middlewares/authMiddleware");

router.get("/restaurante/:restauranteId", ctrl.listarPratosPorRestaurante);
router.get("/:id", ctrl.buscarPrato);
router.post("/", authMiddleware, ctrl.criarPrato);
router.put("/:id", authMiddleware, ctrl.atualizarPrato);
router.delete("/:id", authMiddleware, ctrl.deletarPrato);

module.exports = router;
