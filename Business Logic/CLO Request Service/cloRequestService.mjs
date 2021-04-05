"use strict";

import express from "express"; 
import mysql from "mysql";

import { getServicePort } from "../../API Gateway/apigatewayconfig.mjs";

const db = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '12345',
    database : 'OBE-as-a-Service'
});
db.connect(err => {
    if(err) throw err;
    console.log('CLO Request Service connected to the database.');
});

const app = express();
const port = getServicePort("clo_request");

app.use(express.json());

app.post("/api/clo_request/teacher/add_clo", (req, res) => {
   const {user : {uid, tid}, formData } = req.body;
    db.query(`CALL addCLORequestByTeacher(?,?,?,?,?,?,?,?,?,?,?)`,
        [uid, tid, ...Object.values(formData)],
        (err, result) => err ? res.sendStatus(400) : res.send(result[0][0])
    );
});

app.post("/api/clo_request/teacher/update_clo");
app.post("/api/clo_request/teacher/delete_clo");

app.post("/api/clo_request/obe_cell/add_clo", (req, res) => {
   const {user : {uid, tid}, formData } = req.body;
    db.query(
        `CALL addCLORequestByObeCell(?,?,?,?,?,?,?,?,?,?,?)`,
        [uid, tid, ...Object.values(formData)],
        (err, result) => err ? res.sendStatus(400) : res.send(result[0][0])
    );
});
app.post("/api/clo_request/obe_cell/update_clo");
app.post("/api/clo_request/obe_cell/delete_clo");

app.listen(port, () => {
    console.log("CLO Request Service is running on port:", port);
})

process.on('exit', code => {
    db.end();
    console.log(`CLO Request Service exiting with status ${code}`);
})