import axios from "axios";
import { findServiceIp } from "../apigatewayconfig.mjs";

function mergeObjectsValid (formData, user) {
    const formDataKeys = Object.keys(formData);
    for(let ids in user)
        if(formDataKeys.includes(ids)) return false;
    return true;
}

async function getProxyRequest (req, res) {
    const {user, originalUrl : endPoint, baseUrl, body: formData} = req;
    const serviceName = baseUrl.replace("/api/", "");
    const url = findServiceIp(serviceName) + endPoint;
    let data;
    if(mergeObjectsValid(formData, user)) data = {...formData, ...user};
    else return res.sendStatus(400);
    try {
        const response = await axios.get(url, {params:data});
        res.send({ requestStatus:true, data: response.data });
    }
    catch (err) {
        res.send({ requestStatus:false, err });
    }
}

async function postProxyRequest (req, res) {
    const {user, originalUrl : endPoint, baseUrl, body: formData} = req;
    const serviceName = baseUrl.replace("/api/", "");

    const url = findServiceIp(serviceName) + endPoint;
    try {
        const response = await axios.post(url, {user, formData});
        res.send({ requestStatus:true, data: response.data });
    }
    catch (err) {
        res.send({ requestStatus:false, err });
    }
}

async function putProxyRequest (req, res) {
    const {user, originalUrl : endPoint, baseUrl, body: formData} = req;
    const serviceName = baseUrl.replace("/api/", "");

    const url = findServiceIp(serviceName) + endPoint;
    try {
        const response = await axios.put(url, {user, formData});
        res.send({ requestStatus:true, data: response.data });
    }
    catch (err) {
        res.send({ requestStatus:false, err });
    }
}

export {getProxyRequest, postProxyRequest, putProxyRequest};