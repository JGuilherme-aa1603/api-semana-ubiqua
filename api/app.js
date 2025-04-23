//Adiciona após a conexão com o MongoDB
const express = require('express');
const authRoutes = require('./routes/authRoutes.js');
const postRoutes = require('./routes/postRoutes.js');

const app = express();

app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/post', postRoutes);

module.exports = app;
