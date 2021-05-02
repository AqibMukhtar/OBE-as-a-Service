'use strict';
import { Router, urlencoded } from 'express';
import { postProxyRequest } from '../operations/proxiedRouting.mjs';
import { getJWTSecret } from '../apigatewayconfig.mjs';
import jwt from 'jsonwebtoken';

const passwordAuth = Router();

passwordAuth.use(urlencoded({ extended: false }));

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
        loggedId: true,
        data: jwt.sign({ uid, pid, tid }, getJWTSecret())
      });
    } catch (err) {
      res.sendStatus(401);
    }
  }
}
