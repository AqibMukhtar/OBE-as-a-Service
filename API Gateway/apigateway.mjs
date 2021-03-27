import express from 'express';
import fs from 'fs';
import https from 'https';

import warning from './services/warning.mjs';

import authenticate from "./operations/authentication.mjs";
import authorize from "./operations/authorization.mjs";

import {getAllEndPointsNames, getAPIGatewayPort} from "./apigatewayconfig.mjs";


const app = express();
const validUrls = getAllEndPointsNames();

app.use(({originalUrl}, res, next) => {
    if (validUrls.includes(originalUrl)) next();
    else res.sendStatus(404);
});
app.use(authenticate, authorize);
app.use('/api/warning', warning);
app.get('*', (req, res) => {res.send('Invalid URL')});

https.createServer({
    key: fs.readFileSync('./https/server.key'),
    cert: fs.readFileSync('./https/server.cert')
  }, app)
  .listen(getAPIGatewayPort(), function () {
    console.log('API Gateway running over HTTPS on default port');
  })