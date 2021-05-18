'use strict';
import { Router, json } from 'express';
import { postProxyRequest } from '../operations/proxiedRouting.mjs';
import { getJWTSecret } from '../apigatewayconfig.mjs';
import jwt from 'jsonwebtoken';

const passwordAuth = Router();

passwordAuth.use(json());

passwordAuth.post('/', authenticatePassword, postProxyRequest);

passwordAuth.all('*', (req, res) => res.sendStatus(404));

export default passwordAuth;

function authenticatePassword(req, res, next) {
  const token = req.headers['x-access-token'];
  if (!token) next();
  else {
    try {
      const { uid, pid, tid } = jwt.verify(token, getJWTSecret());
      res.send({
        loggedIn: true,
        data: jwt.sign({ uid, pid, tid }, getJWTSecret())
      });
    } catch (err) {
      res.sendStatus(401);
    }
  }
}
