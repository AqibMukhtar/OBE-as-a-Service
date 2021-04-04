import express from 'express';
import {readFileSync} from 'fs';
import {createServer} from 'https';
import jwt from 'jsonwebtoken';

import peoManagement from './services/peoManagement.mjs';

import authenticate from "./operations/authentication.mjs";

import {getAPIGatewayPort} from "./apigatewayconfig.mjs";


const app = express();

app.use(authenticate);
app.use('/api/peo_management', peoManagement);
app.get('/token', (req, res) => {
  res.send(jwt.sign({uid:1, pid:1, tid:3}, "topsecret"));
})
app.all('*', (req, res) => res.sendStatus(404)); 

createServer({
    key: readFileSync('./https/server.key'),
    cert: readFileSync('./https/server.cert')
  }, app)
  .listen(getAPIGatewayPort(), function () {
    console.log('API Gateway running over HTTPS on default port');
  })

  //tid2 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInBpZCI6MSwidGlkIjoyLCJpYXQiOjE2MTc0MzQ5NjF9.EsEs6H55lDmVxi8oF80_8r-OEc1W6pczKUSSEDv-KiI
  //tid3 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInBpZCI6MSwidGlkIjozLCJpYXQiOjE2MTc0MzU1ODF9.koa38_gTzK2GSPFsvCm7wM_jBGZu7BBc8pZ4UNr9MC8