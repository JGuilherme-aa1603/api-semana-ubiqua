const express = require('express');
const router = express.Router();
const Post = require('../models/Post');

// Criar postagem
router.post('/', async (req, res) => {
  try {
    const { title, content, author, tags } = req.body;
    const post = new Post({ title, content, author, tags });
    await post.save();
    res.status(201).json(post);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar postagens
router.get('/', async (req, res) => {
  const posts = await Post.find().populate('author', 'name');
  res.json(posts);
});

module.exports = router;
