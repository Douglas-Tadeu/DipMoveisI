const express = require("express");
const router = express.Router();
const ctrl = require("../controllers/restaurantesController");
const { authMiddleware } = require("../middlewares/authMiddleware");

router.get("/", ctrl.listarRestaurantes);
router.get("/:id", ctrl.buscarRestaurante);
router.post("/", authMiddleware, ctrl.criarRestaurante);
router.put("/:id", authMiddleware, ctrl.atualizarRestaurante);
router.delete("/:id", authMiddleware, ctrl.deletarRestaurante);

module.exports = router;
