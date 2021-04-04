import express from 'express';
import mysql from 'mysql';

import { getServicePort } from "../../API Gateway/apigatewayconfig.mjs";

const app = express();
const port = getServicePort("peo_management");

const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '12345',
    database : 'OBE-as-a-Service'
});
db.connect(err => {
    if(err) throw err;
    console.log('PEO Management Service connected to the database.');
});

app.use(express.json());

//Add PEO by OBE Cell
app.post('/api/peo_management/obe_cell/add_peo', (req, res) => {
    const { user : {uid, pid}, formData : {peoDescription, ploId}} = req.body;
    db.query(`CALL approvePEOAddition(?,?,?,?)`,
    [pid, uid, peoDescription, ploId], 
    (err,result) => {
        if(err) res.sendStatus(400);
        else {
            const {Message : message, Success : success} = result[0][0];
            res.send({ message, success });
        }
    });
});

//Commit PEO Addition by OBE Cell
app.put('/api/peo_management/admin/add_peo/:peoName', (req, res) => {
    const { user : {uid, pid}} = req.body;
    const { peoName } = req.params;
    db.query(`CALL commitPEOAddition(?,?,?)`, [pid, uid, peoName], 
    (err,result) => {
        if(err) res.sendStatus(400);
        else {
            const {Message : message, Success : success} = result[0][0];
            res.send({ message, success });
        }
    });
});

app.listen(port, () => {
    console.log("PEO Management Service is running on port:", port);
})

process.on('exit', code => {
    db.end();
    console.log(`PEO Management Service exiting with status ${code}`);
})