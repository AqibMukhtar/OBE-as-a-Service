import express from 'express';
import cors from 'cors';
import { readFileSync } from 'fs';
import { createServer } from 'https';

import peoManagement from './services/peoManagement.mjs';
import cloRequest from './services/cloRequest.mjs';
import cloCommit from './services/cloCommit.mjs';
import cloApprove from './services/cloApprove.mjs';
import passwordAuth from './services/passwordAuthentication.mjs';
import cds from './services/cds.mjs';

import authenticate from './operations/authentication.mjs';

import { getAPIGatewayPort } from './apigatewayconfig.mjs';

const app = express();

app.use(cors());

app.use('/api/password_auth', passwordAuth);

app.use(authenticate);

app.use('/api/peo_management', peoManagement);
app.use('/api/clo_request', cloRequest);
app.use('/api/clo_approve', cloApprove);
app.use('/api/clo_commit', cloCommit);
app.use('/api/cds', cds);

app.all('*', (req, res) => res.sendStatus(404));

createServer(
  {
    key: readFileSync('./https/server.key'),
    cert: readFileSync('./https/server.cert')
  },
  app
).listen(getAPIGatewayPort(), function () {
  console.log('API Gateway running over HTTPS on default port');
});
