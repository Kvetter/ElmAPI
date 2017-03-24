var express = require('express');
var router = express.Router();
var counter = require("../model/counter")

/* GET home page. */
router.get('/counter', function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8000');
  res.json({ data: counter.getCounter() });
});

router.put('/counter/:num', function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8000');
  res.json({ data: counter.setCounter(req.params.num) });
});

module.exports = router;
