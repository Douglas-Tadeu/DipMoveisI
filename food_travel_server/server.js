const express = require("express");
const cors = require("cors");
const path = require("path");

const authRoutes = require("./routes/auth");
const usuariosRoutes = require("./routes/usuarios");
const restaurantesRoutes = require("./routes/restaurantes");
const pratosRoutes = require("./routes/pratos");
const favoritosRoutes = require("./routes/favoritos");
const avaliacoesRoutes = require("./routes/avaliacoes");

const app = express();
app.use(cors());
app.use(express.json());

// pasta para uploads
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// rotas
app.use("/auth", authRoutes);
app.use("/usuarios", usuariosRoutes);
app.use("/restaurantes", restaurantesRoutes);
app.use("/pratos", pratosRoutes);
app.use("/favoritos", favoritosRoutes);
app.use("/avaliacoes", avaliacoesRoutes);

// rota raiz
app.get("/", (req, res) => res.json({ message: "API Food Travel rodando" }));

const PORT = process.env.PORT || 5500;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
