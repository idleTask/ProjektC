const express = require('express');
const router = express.Router();
const multer = require('multer');
const checkAuth = require('../middleware/check-auth');
const ItemController = require('../controllers/item');
const fs = require('fs');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    var dir = './uploads/' + req.userData._id + '/';
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir);
    }
    cb(null, dir);
  },
  filename: function (req, file, cb) {
    var name = file.originalname.replace(/\s+/g, '');;
    console.log(name);
    cb(null, Date.now() + name);
  }
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
    cb(null, true);
  } else {
    cb(null, false);
  }
};
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5
  },
  fileFilter: fileFilter
});

router.get('/', checkAuth, ItemController.items_get_all);

router.post('/', checkAuth, upload.single('itemImage'), ItemController.items_post);

router.get('/:itemId', checkAuth, ItemController.items_itemId_get);

router.patch('/:itemId', checkAuth, ItemController.items_itemId_patch);

router.delete("/:itemId", checkAuth, ItemController.items_itemId_delete);

module.exports = router;