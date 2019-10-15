const mongoose = require('mongoose');

const itemSchema = mongoose.Schema({
  _id: mongoose.Schema.Types.ObjectId,
  title: {type: String, required: true},
  description: {type: String, required: false},
  itemImage: {type: String, required: true},
  userId: {type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true},
});

module.exports = mongoose.model('Item', itemSchema);