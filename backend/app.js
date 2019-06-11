const express = require('express');
const app = express();
const morgan = require('morgan');

const imagesRoutes = require('./api/routes/images');

app.use(morgan('dev'));

app.use('/images', imagesRoutes);

app.use((req, res, next) => {
  const error = new Error('Not found');
  error.status = 404;
  next(error);
});

app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.json({
    error: {
      message: err.message,

    }
  })
});
module.exports = app;