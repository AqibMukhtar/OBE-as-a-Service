import http from './httpService';
import { apiUrl } from '../config.json';
import jwtDecode from 'jwt-decode';

const apiEndPoint = apiUrl;

export function login(userName, password, type) {
  return http.post(apiEndPoint, { userName, password, type });
}

export function getCurrentUser() {
  try {
    const jwt = localStorage.getItem('token');
    const user = jwtDecode(jwt);
    return user;
  } catch (ex) {
    return null;
  }
}
