const express = require('express');
const router = express.Router();

router.get('/', (req, res, next) => {
  res.status(200).json({
    message: 'Handling get request to /images!<c'
  });
});

router.post('/', (req, res, next) => {
  res.status(201).json({
    message: 'Handling post request to /images'
  });
});

router.get('/:imageId', (req, res, next) => {
  const id = req.params.imageId;
  res.status(200).json({
    message: 'get image with id',
    id: id
  })
});

router.delete('/:imageId', (req, res, next) => {
  const id = req.params.imageId;
  res.status(200).json({
    message: 'delete image with id',
    id: id
  })
});

module.exports = router;