const mongoose = require('mongoose');
const Item = require('../models/item');

exports.items_get_all = (req, res, next) => {
  Item.find().select('title description _id itemImage userId').then(
    docs => {
      const response = {
        count: docs.length,
        items: docs.map(doc => {
          return {
            title: doc.title,
            description: doc.description,
            id: doc._id,
            itemImage: doc.itemImage,
            userId: doc.userId
          }
        })
      };
      res.status(200).json(response);
    }
  ).catch(err => {
    console.log(err);
    res.status(500).json({ error: err });
  });
}

exports.items_post = (req, res, next) => {
  const item = new Item({
    _id: new mongoose.Types.ObjectId(),
    title: req.body.title,
    description: req.body.description,
    itemImage: req.file.path,
    userId: req.userData._id
  });
  item.save().then(result => {
    console.log(result);
    res.status(201).json({
      message: 'Created item successfully',
      createdItem: {
        title: result.title,
        description: result.description,
        itemImage: result.itemImage,
        _id: result._id,
        userId: result.userId
      },
    });
  }).catch(err => {
    console.log(err)
    res.status(500).json({ error: err })
  });
}

exports.items_itemId_get = (req, res, next) => {
  const id = req.params.itemId;

  Item.findById(id).select('title description _id itemImage userId').then(doc => {
    console.log(doc);
    if (doc) {
      res.status(200).json(doc);
    } else {
      res.status(404).json({ message: 'No valid entry found for that Id' });
    }
  }).catch(err => {
    console.log(err)
    res.status(500).json({ error: err });
  });
}

exports.items_itemId_patch = (req, res, next) => {
  console.log(req.body);
  const id = req.params.itemId;
  const updateOps = {};
  for (const ops of req.body) {
    updateOps[ops.propName] = ops.value;
  }
  Item.update({ _id: id }, { $set: updateOps }).then(result => {
    res.status(200).json(result);
  }).catch(err => {
    console.log(err);
    res.status(500).json({ error: err });
  });
}

exports.items_itemId_delete = (req, res, next) => {
  const id = req.params.itemId;
  Item.remove({ _id: id }).then(result => {
    res.status(200).json(result);
  }).catch(err => {
    console.log(err);
    res.status(500).json({ error: err });
  });
}