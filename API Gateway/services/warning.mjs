import { Router } from 'express';
import { getProxyRequest } from '../operations/proxiedRouting.mjs';

const warning = Router();

warning.get('/teacher/incomplete_clo_assessment', getProxyRequest);
warning.get('/teacher/incomplete_marks/sessional', getProxyRequest);

export default warning;