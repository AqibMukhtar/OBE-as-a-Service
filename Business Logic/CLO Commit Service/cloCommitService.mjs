'use strict';

import express from 'express';
import { createConnection } from 'mysql';

import { getServicePort } from '../../API Gateway/apigatewayconfig.mjs';

const db = createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345',
  database: 'OBE-as-a-Service'
});
db.connect(err => {
  if (err) throw err;
  console.log('CLO Commit Service connected to the database.');
});

const app = express();
const port = getServicePort('clo_commit');

app.use(express.json());

app.put('/api/clo_commit/add_clo/:add_id', (req, res) => {
  const {
    body: {
      user: { uid }
    },
    params: { add_id }
  } = req;
  db.query(`CALL addCLOCommitByAdmin(?, ?);`, [add_id, uid], (err, result) =>
    err ? res.sendStatus(400) : res.send(result[0][0])
  );
});

app.put('/api/clo_commit/update_clo/:update_id', (req, res) => {
  const {
    body: {
      user: { uid }
    },
    params: { update_id }
  } = req;
  db.query(
    `CALL editCLOCommitByAdmin(?, ?);`,
    [update_id, uid],
    (err, result) => (err ? res.sendStatus(400) : res.send(result[0][0]))
  );
});

app.put('/api/clo_commit/delete_clo/:delete_id', (req, res) => {
  const {
    body: {
      user: { uid }
    },
    params: { delete_id }
  } = req;
  db.query(
    `CALL deleteCLOCommitByAdmin(?, ?);`,
    [delete_id, uid],
    (err, result) => (err ? res.sendStatus(400) : res.send(result[0][0]))
  );
});

app.listen(port, () => {
  console.log('CLO Commit Service is running on port:', port);
});

process.on('exit', code => {
  db.end();
  console.log(`CLO Commit Service exiting with status ${code}`);
});
