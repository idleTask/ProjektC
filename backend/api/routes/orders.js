const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

const Order = require('../models/order');
const Item = require('../models/item');

router.get('/', (req, res, next) => {
  Order.find().select('item quantity _id').then(docs => {
    res.status(200).json({
      count: docs.length,
      orders: docs.map(doc => {
        return {
          _id: doc._id,
          item: doc.item,
          quantity: doc.quantity,
          request: {
            type: 'GET',
            url: '/item/' + doc._id
          }
        };
      }),
    });
  }).catch(err => {
    res.status(500).json(err => { error: err });
  });
});

router.post('/', (req, res, next) => {
  Item.findById(req.body.itemId).then(
    item => {
      if (!item) {
        return res.status(404).json({
          message: 'Item not found'
        });
      }
      const order = new Order({
        _id: mongoose.Types.ObjectId(),
        quantity: req.body.quantity,
        item: req.body.itemId
      });
      return order.save();
    }
  ).then(result => {
    console.log(result);
    res.status(201).json({
      message: 'Order stored',
    })
  }).catch(err => {
    console.log(err);
    res.status(500).json({ error: err });
  });

});

module.exports = router;