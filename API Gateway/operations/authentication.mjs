import jwt from 'jsonwebtoken';
import { getJWTSecret } from '../apigatewayconfig.mjs';

function authenticate(req, res, next) {
  const token = req.headers['x-access-token'];
  if (!token) res.sendStatus(401);
  else {
    try {
      const payload = jwt.verify(token, getJWTSecret());
      const { uid, pid, tid } = payload;
      req.user = { uid, pid, tid };
      next();
    } catch (err) {
      res.sendStatus(401);
    }
  }
}

export default authenticate;
