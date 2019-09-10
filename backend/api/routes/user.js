const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user');

const checkAuth = require('../middleware/check-auth');

// router.post('/signup', UserController.user_signup_post);

router.post('/login', UserController.user_login_post);

router.delete('/:userId', checkAuth, UserController.user_delete);

router.get('/', checkAuth, UserController.user_get);

router.get('/all', checkAuth, UserController.user_all_get);

module.exports = router;