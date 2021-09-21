import { Router, json } from 'express';
import { postProxyRequest } from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const assessmentToolDefinition = Router();

assessmentToolDefinition.use(json());

assessmentToolDefinition.post('/teacher/sessional/theory/', authorize, postProxyRequest);
assessmentToolDefinition.post('/teacher/sessional/practical/', authorize, postProxyRequest);
assessmentToolDefinition.post('/teacher/final/theory/', authorize, postProxyRequest);
assessmentToolDefinition.post('/teacher/final/practical/', authorize, postProxyRequest);

assessmentToolDefinition.all('*', (req, res) => res.sendStatus(404));

export default assessmentToolDefinition;