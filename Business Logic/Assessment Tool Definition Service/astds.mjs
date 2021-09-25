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
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName, totalMarks
  }} = req.body;
  db.query('CALL addAssessmentToolSessionalTheory(?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0]));
});

app.post('/api/assessment_tool_definition/teacher/sessional/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName, totalMarks
  }} = req.body;
  db.query('CALL addAssessmentToolSessionalPractical(?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0]));  
});

app.post('/api/assessment_tool_definition/teacher/final/theory/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName, totalMarks
  }} = req.body;
  db.query('CALL addAssessmentToolFinalTheory(?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/final/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName, totalMarks
  }} = req.body;
  db.query('CALL addAssessmentToolFinalPractical(?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});


app.post('/api/assessment_tool_definition/teacher/update/sessional/theory/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks
  }} = req.body;
  db.query('CALL updateAssessmentToolSessionalTheory(?,?,?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/update/sessional/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks
  }} = req.body;
  db.query('CALL updateAssessmentToolSessionalPractical(?,?,?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/update/final/theory/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks
  }} = req.body;
  db.query('CALL updateAssessmentToolFinalTheory(?,?,?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/update/final/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks
  }} = req.body;
  db.query('CALL updateAssessmentToolFinalPractical(?,?,?,?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, newToolName, cloName, newCloName, totalMarks],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});


app.post('/api/assessment_tool_definition/teacher/delete/sessional/theory/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName
  }} = req.body;
  db.query('CALL deleteAssessmentToolSessionalTheory(?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/delete/sessional/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName
  }} = req.body;
  db.query('CALL deleteAssessmentToolSessionalPractical(?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/delete/final/theory/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName
  }} = req.body;
  db.query('CALL deleteAssessmentToolFinalTheory(?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});

app.post('/api/assessment_tool_definition/teacher/delete/final/practical/', (req, res) => {
  const { user : {uid : teacherId}, formData : {
    programName, batchId, courseName, courseCode, sectionName, toolName, cloName
  }} = req.body;
  db.query('CALL deleteAssessmentToolFinalPractical(?,?,?,?,?,?,?,?)', 
  [programName, batchId, teacherId, courseName, courseCode, sectionName, toolName, cloName],
  (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
});


app.post('/api/assessment_tool_definition/teacher/mark_conducted/', (req, res) => {
  const {formData : {type, toolId}} = req.body;
  switch(type) {
    case 'final':
      db.query('CALL markFinalToolConducted(?)', [toolId],
      (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
      break;
    case 'sessional':
      db.query('CALL markSessionalToolConducted(?)', [toolId],
      (err, result) => err ? res.sendStatus(400) : res.send(result[0])); 
      break;
    default:
      res.sendStatus(400);
  }
});

app.listen(port, () => {
  console.log('Assessment Tool Definition Service is running on port:', port);
});

process.on('exit', code => {
  db.end();
  console.log(`Assessment Tool Definition Service exiting with status ${code}`);
});
