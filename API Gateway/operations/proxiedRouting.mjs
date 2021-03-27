import axios from "axios";
import { findServiceIp } from "../apigatewayconfig.mjs";

async function getProxyRequest (req, res) {
    const {user, originalUrl : endPoint, baseUrl} = req;
    const serviceName = baseUrl.replace("/api/", "");

    const url = findServiceIp(serviceName) + endPoint;
    try {
        const response = await axios.get(url, {params:user});
        res.send({ requestStatus:true, data: response.data });
    }
    catch (err) {
        res.send({ requestStatus:false, err });
    }
}

export {getProxyRequest};

// async function fun() {
//     console.log(await getProxyRequest("warning", "/api/warning/teacher/incomplete_clo_assessment/"));
// }

// fun();