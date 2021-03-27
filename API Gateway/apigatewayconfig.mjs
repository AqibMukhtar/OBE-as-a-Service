//authUsers 1=Teacher
//authUser is equals to tid
//Use following command to issue a certificate
//openssl req -nodes -new -x509 -keyout server.key -out server.cert
const configurationData = {
    "jwtsecret" : "topsecret",
    "apiGatewayPort" : 443,
    "services" : {
        "warning" : {
            "ip" : "127.0.0.1",
            "protocol" : "http",
            "port" : "3000",
            "endpoints" : [
                {
                    "name" : "/api/warning/teacher/incomplete_clo_assessment",
                    "authUsers" : [2]
                },
                {
                    "name" : "/api/warning/teacher/incomplete_marks/sessional",
                    "authUsers" : [1,2]
                }
            ]
        },
        "assessment_tool_grading" : {
            "ip" : "127.0.0.1",
            "protocol" : "http",
            "port" : "4000",
            "endpoints" : [
                {
                    "name" : "/api/assessment_tool_grading/sessional",
                    "authUsers" : [2]
                },
                {
                    "name" : "/api/assessment_tool_grading/final",
                    "authUsers" : [1,2]
                }
            ]
        }
    }
}

export function findServiceIp (serviceName) {
    const {ip, protocol, port} = configurationData.services[serviceName];
    return ( protocol + "://" + ip + ":" + port );
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
        serviceEndpoints.forEach(({name}) => {
            allEndPointsNames.push(name);
        })
    }
    return allEndPointsNames;
}

export function getAPIGatewayPort () {
    return configurationData.apiGatewayPort;
}
