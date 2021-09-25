import { Router, json } from 'express';
import { putProxyRequest } from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const cloApprove = Router();

cloApprove.use(json());

cloApprove.put('/add_clo/:add_id', authorize, putProxyRequest);
cloApprove.put('/update_clo/:update_id', authorize, putProxyRequest);
cloApprove.put('/delete_clo/:delete_id', authorize, putProxyRequest);

cloApprove.all('*', (req, res) => res.sendStatus(404));

export default cloApprove;
