const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const User = require('../models/user');
const Item = require('../models/item');

exports.user_signup_post = (req, res, next) => {
  User.find({ email: req.body.email }).then(user => {
    if (user.length >= 1) {
      return res.status(409).json({
        message: 'Mail exists'
      });
    } else {
      User.find({ name: req.body.name }).then(user => {
        if (user.length >= 1) {
          return res.status(409).json({
            message: 'Username exists'
          });
        } else {
          bcrypt.hash(req.body.password, 10, (err, hash) => {
            if (err) {
              return res.status(500).json({
                error: err
              });
            } else {
              const user = new User({
                _id: new mongoose.Types.ObjectId(),
                name: req.body.name,
                email: req.body.email,
                password: hash
              });
              user.save().then(result => {
                res.status(201).json({ message: 'User created' });
              }).catch(err => {
                res.status(500).json({ error: err });
              });
            }
          });
        }
      });
    }
  })
};

exports.user_login_post = (req, res, next) => {
  User.find({ email: req.body.email })
    .then(
      user => {
        if (user.length < 1) {
          return res.status(401).json({
            message: 'Auth failed'
          });
        }
        bcrypt.compare(req.body.password, user[0].password, (err, result) => {
          if (err) {
            return res.status(401).json({
              message: 'Auth failed'
            });
          }
          if (result) {
            const token = jwt.sign({
              email: user[0].email,
              name: user[0].name,
              _id: user[0]._id
            }, process.env.JWT_KEY, {
                expiresIn: "1h"
              });
            return res.status(200).json({
              message: 'Auth successful',
              token: token
            });
          }
          return res.status(401).json({
            message: 'Auth failed'
          });
        });
      }
    ).catch(err => {
      return res.status(500).json({
        error: err
      });
    });
};

exports.user_delete = (req, res, next) => {
  User.remove({ _id: req.params.userId }).then(result => {
    res.status(200).json({ message: 'user deleted' })
  }).catch(err => {
    res.status(500).json({
      error: err
    });
  });
}

exports.user_get = (req, res, next) => {
  var items;
  Item.find({userId: req.userData._id}).select('-__v').then(result => {
    items = result;
    console.log(result);
  }).catch(error => {
    console.log(error);
  });
  User.find({ _id: req.userData._id }).then(result => {
    res.status(200).json({ name: result[0].name, email: result[0].email, id: result[0]._id, items: items})
  }).catch(err => {
    res.status(500).json({
      error: err
    });
  });
}

exports.user_all_get = (req, res, next) => {
  User.find().select('name email _id ').then(
    docs => {
      const response = {
        count: docs.length,
        users: docs.map(doc => {
          return {
            name: doc.name,
            email: doc.email,
            id: doc._id
          }
        })
      };
      res.status(200).json(response);
    }
  ).catch(err => {
    console.log(err);
    res.status(500).json({ error: err , message: 'all users'});
  });
}