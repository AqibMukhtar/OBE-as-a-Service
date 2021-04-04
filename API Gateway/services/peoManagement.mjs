import { Router } from 'express';
import { urlencoded } from 'express';
import { getProxyRequest, postProxyRequest, putProxyRequest } from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const peoManagement = Router();

peoManagement.use(urlencoded({extended:false}));

peoManagement.post('/obe_cell/add_peo', authorize, postProxyRequest);
peoManagement.put('/admin/add_peo/:peoName', authorize, putProxyRequest);

peoManagement.all('*', (req, res) => res.sendStatus(404));

export default peoManagement;