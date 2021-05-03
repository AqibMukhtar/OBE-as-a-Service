import { Router } from 'express';
import { urlencoded } from 'express';
import { putProxyRequest } from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const cloCommit = Router();

cloCommit.use(urlencoded({extended:false}));

cloCommit.put('/add_clo/:add_id', authorize, putProxyRequest);
cloCommit.put('/update_clo/:update_id', authorize, putProxyRequest);
cloCommit.put('/delete_clo/:delete_id', authorize, putProxyRequest);

cloCommit.all('*', (req, res) => res.sendStatus(404));

export default cloCommit;