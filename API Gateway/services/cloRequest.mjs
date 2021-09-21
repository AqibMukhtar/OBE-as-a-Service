import { Router } from 'express';
import { json } from 'express';
import { postProxyRequest} from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const cloRequest = Router();

cloRequest.use(jaon());

cloRequest.post('/teacher/add_clo', authorize, postProxyRequest);
cloRequest.post('/teacher/update_clo', authorize, postProxyRequest);
cloRequest.post('/teacher/delete_clo', authorize, postProxyRequest);

cloRequest.post('/obe_cell/add_clo', authorize, postProxyRequest);
cloRequest.post('/obe_cell/update_clo', authorize, postProxyRequest);
cloRequest.post('/obe_cell/delete_clo', authorize, postProxyRequest);

cloRequest.all('*', (req, res) => res.sendStatus(404));

export default cloRequest;