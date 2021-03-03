var express = require('express');
var router = express.Router();

let config = require('../config.json')
const oracledb = require('oracledb')

/* GET home page. */
router.get('/', async function(req, res, next) {
  oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;
    let connection;
    try {
      connection = await oracledb.getConnection(config.oracle);
      if(connection) {
        console.log(`Connected successfully to oracle db!`)
        res.send({code: 200, message: "Successfully connected to oracle database!"})
      }
    } catch(error) {
      console.log(`Error: ${error}`)
    }
});

module.exports = router;
