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
  console.log('Content Delivery Service connected to the database.');
});

const app = express();
const port = getServicePort('cds');

app.get('/api/cds/teacher/view_teaching_course/', (req, res) => {
  const { uid: teacherId } = req.query;
  db.query(`CALL getTechingCourses(?);`, [teacherId], (err, result) =>
    err ? res.sendStatus(400) : res.send(result[0])
  );
});

app.get('/api/cds/view_course_clos/', (req, res) => {
  const {programId, courseId} = req.query;
  db.query(`CALL getCLOsOfCourse(?, ?)`, [programId, courseId], (err, result) =>
    err ? res.sendStatus(400) : res.send(result[0])
  );
});

app.get('/api/cds/teacher/view_assessment_tools/', (req, res) => {
  const {programId, courseId, uid : teacherId, batchId} = req.query;
  db.query('CALL viewAssessmentToolsOfCourse(?,?,?,?)', [teacherId, programId, courseId, batchId], (err, result) =>
    err ? res.sendStatus(400) : res.send(result[0])
  );
});

app.listen(port, () => {
  console.log('Content Delivery Service is running on port:', port);
});

process.on('exit', code => {
  db.end();
  console.log(`Content Delivery Service exiting with status ${code}`);
});
