import { authorizeUserToEndPoint } from "../apigatewayconfig.mjs";

function authorize(req, res, next) {
    const {user : {tid}, baseUrl, route : {path}} = req;
    const originalUrl = baseUrl + path;
    const serviceName = originalUrl.replace("/api/", "").replace(/\/.*/g, "");
    if(authorizeUserToEndPoint(serviceName, originalUrl, tid)) next();
    else res.sendStatus(403);
}

export default authorize;