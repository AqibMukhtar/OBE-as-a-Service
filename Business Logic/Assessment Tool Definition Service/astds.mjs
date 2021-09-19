'use strict';

import express from 'express';
import { createConnection } from 'mysql';
import { getServicePort } from '../../API Gateway/apigatewayconfig.mjs';

const db = createConnection({
  host: 'localhost',
  user: 'root',
  password: 'OBEaaS123',
  database: 'OBE-as-a-Service'
});
db.connect(err => {
  if (err) throw err;
  console.log('Assessment Tool Definition Service connected to the database.');
});

const app = express();
const port = getServicePort('assessment_tool_definition');

app.use(express.json());

app.post('/api/assessment_tool_definition/teacher/sessional/theory/', (req, res) => {
  const { user : {uid, pid}, formData} = req.body;
  res.send(formData);
  console.log(req);
});

app.listen(port, () => {
  console.log('Assessment Tool Definition Service is running on port:', port);
});

process.on('exit', code => {
  db.end();
  console.log(`Assessment Tool Definition Service exiting with status ${code}`);
});
