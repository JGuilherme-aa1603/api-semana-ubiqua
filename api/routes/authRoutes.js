const express = require('express');
const { login, register, profile, test } = require('../controllers/authController.js');
const authMiddleware = require('../middlewares/authMiddleware.js');

const router = express.Router();

router.post('/login', login);
router.post('/register', register);
router.get('/profile', authMiddleware, profile);
router.get('/test', test);

module.exports = router;
