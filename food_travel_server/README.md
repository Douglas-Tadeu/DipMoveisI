1. Dentro da pasta food_travel_server rode:

npm install


2. Criar a pasta uploads (para imagens):

mkdir uploads


3. Rodar em modo desenvolvimento:

npm run dev
# ou
node server.js


4. Endpoints:

POST /auth/login — body: { email, senha }

POST /auth/register — body: { nome, email, senha }

GET /restaurantes

POST /restaurantes (auth)

GET /pratos/restaurante/:restauranteId

POST /pratos (auth)

POST /favoritos (auth) body: { usuarioId, pratoId? , restauranteId? }

GET /favoritos/:usuarioId (auth)

POST /avaliacoes (auth) body: { usuarioId, pratoId, nota, comentario }

etc.