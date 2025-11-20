const express = require("express");
const router = express.Router();
const ctrl = require("../controllers/avaliacoesController");
const { authMiddleware } = require("../middlewares/authMiddleware");

router.post("/", authMiddleware, ctrl.adicionarAvaliacao);
router.get("/prato/:pratoId", ctrl.listarAvaliacoesPorPrato);
router.delete("/:id", authMiddleware, ctrl.removerAvaliacao);

module.exports = router;
