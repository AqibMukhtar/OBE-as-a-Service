import { Router } from 'express';
import { getProxyRequest } from '../operations/proxiedRouting.mjs';
import authorize from '../operations/authorization.mjs';

const cds = Router();

cds.get('/teacher/view_teaching_course/', authorize, getProxyRequest);
cds.get('/view_course_clos/', authorize, getProxyRequest);
cds.get('/teacher/view_assessment_tools/', authorize, getProxyRequest);
cds.get('/view_name/', authorize, getProxyRequest);
cds.get('/admin/uncommitted_clo_addition/', authorize, getProxyRequest);
cds.get('/admin/uncommitted_clo_updation/', authorize, getProxyRequest);
cds.get('/admin/uncommitted_clo_deletion/', authorize, getProxyRequest);

cds.all('*', (req, res) => res.sendStatus(404));

export default cds;
