//authUsers 1=Teacher, 2=Obe Cell, 3=Admin
//authUser is equals to tid
//Use following command to issue a certificate
//openssl req -nodes -new -x509 -keyout server.key -out server.cert
const configurationData = {
    "jwtsecret" : "topsecret",
    "apiGatewayPort" : 443,
    "services" : {
        "peo_management" : {
            "ip" : "127.0.0.1",
            "protocol" : "http",
            "port" : "3000",
            "endpoints" : [
                {
                    "name" : "/api/peo_management/obe_cell/add_peo",
                    "authUsers" : [2]
                },
                {
                    "name" : "/api/peo_management/admin/add_peo/:peoName",
                    "authUsers" : [3]
                }
            ]
        }
    }
}

export function findServiceIp (serviceName) {
    const {ip, protocol, port} = configurationData.services[serviceName];
    return ( protocol + "://" + ip + ":" + port );
}

export function getServicePort (serviceName) {
    return configurationData.services[serviceName].port;
}

export function getAPIGatewayPort () {
    return configurationData.apiGatewayPort;
}

export function getJWTSecret() {
    return configurationData.jwtsecret;
}

export function authorizeUserToEndPoint (serviceName, endpointName, tid) {
    const {endpoints} = configurationData.services[serviceName];
    const endpoint = endpoints.filter(({name}) => name === endpointName);
    return endpoint[0].authUsers.includes(tid);
}

export function getAllEndPointsNames () {
    const {services} = configurationData;
    let allEndPointsNames = [];
    for(let serviceName in services) {
        const serviceEndpoints = services[serviceName]["endpoints"];
        serviceEndpoints.forEach(({name}) => { allEndPointsNames.push(name) })
    }
    return allEndPointsNames;
}

