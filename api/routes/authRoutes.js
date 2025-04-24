const express = require('express');
const { login, register, profile } = require('../controllers/authController.js');
const authMiddleware = require('../middleware/authMiddleware.js');

const router = express.Router();

router.post('/login', login);
router.post('/register', register);
router.get('/profile', authMiddleware, profile);
