//authUsers 1=Teacher, 2=Obe Cell, 3=Admin, 4=Student
//authUser is equals to tid
//Use following command to issue a certificate
//openssl req -nodes -new -x509 -keyout server.key -out server.cert
const configurationData = {
  jwtsecret: 'topsecret',
  apiGatewayPort: 443,
  services: {
    peo_management: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '3000',
      endpoints: [
        {
          name: '/api/peo_management/obe_cell/add_peo',
          authUsers: [2]
        },
        {
          name: '/api/peo_management/admin/add_peo/:peoName',
          authUsers: [3]
        }
      ]
    },
    clo_request: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '4000',
      endpoints: [
        {
          name: '/api/clo_request/teacher/add_clo',
          authUsers: [1]
        },
        {
          name: '/api/clo_request/teacher/update_clo',
          authUsers: [1]
        },
        {
          name: '/api/clo_request/teacher/delete_clo',
          authUsers: [1]
        },
        {
          name: '/api/clo_request/obe_cell/add_clo',
          authUsers: [2]
        },
        {
          name: '/api/clo_request/obe_cell/update_clo',
          authUsers: [2]
        },
        {
          name: '/api/clo_request/obe_cell/delete_clo',
          authUsers: [2]
        }
      ]
    },
    clo_commit: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '5000',
      endpoints: [
        {
          name: '/api/clo_commit/add_clo/:add_id',
          authUsers: [3]
        },
        {
          name: '/api/clo_commit/update_clo/:update_id',
          authUsers: [3]
        },
        {
          name: '/api/clo_commit/delete_clo/:delete_id',
          authUsers: [3]
        }
      ]
    },
    password_auth: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '6000',
      endpoints: [
        {
          name: '/api/password_auth',
          authUsers: [1, 2, 3, 4]
        }
      ]
    },
    clo_approve: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '7000',
      endpoints: [
        {
          name: '/api/clo_approve/add_clo/:add_id',
          authUsers: [2]
        },
        {
          name: '/api/clo_approve/update_clo/:update_id',
          authUsers: [2]
        },
        ,
        {
          name: '/api/clo_approve/delete_clo/:delete_id',
          authUsers: [2]
        }
      ]
    },
    cds: {
      ip: '127.0.0.1',
      protocol: 'http',
      port: '8000',
      endpoints: [
        {
          name: '/api/cds/teacher/view_teaching_course/',
          authUsers: [1]
        },
        {
          name: '/api/cds/view_course_clos/',
          authUsers: [1, 2, 3, 4]
        },
        {
          name: '/api/cds/teacher/view_assessment_tools/',
          authUsers: [1]
        }
      ]
    }
  }
};

export function findServiceIp(serviceName) {
  const { ip, protocol, port } = configurationData.services[serviceName];
  return protocol + '://' + ip + ':' + port;
}

export function getServicePort(serviceName) {
  return configurationData.services[serviceName].port;
}

export function getAPIGatewayPort() {
  return configurationData.apiGatewayPort;
}

export function getJWTSecret() {
  return configurationData.jwtsecret;
}

export function authorizeUserToEndPoint(serviceName, endpointName, tid) {
  const { endpoints } = configurationData.services[serviceName];
  const endpoint = endpoints.filter(({ name }) => name === endpointName);
  //endpoint[0].authUsers.includes(tid);
  return endpoint[0] ? endpoint[0].authUsers.includes(tid) : false;
}

export function getAllEndPointsNames() {
  const { services } = configurationData;
  let allEndPointsNames = [];
  for (let serviceName in services) {
    const serviceEndpoints = services[serviceName]['endpoints'];
    serviceEndpoints.forEach(({ name }) => {
      allEndPointsNames.push(name);
    });
  }
  return allEndPointsNames;
}
