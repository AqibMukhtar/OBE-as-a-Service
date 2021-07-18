// import jwtDecode from "jwt-decode";
import http from "./httpService";
import { apiUrl } from "../config.json";

const apiEndPoint = apiUrl;
const tokenKey = "token";

export async function login(userName, password, type) {
  const { data: jwt } = await http.post(apiEndPoint, {
    userName,
    password,
    type,
  });
  return jwt;
}

export function logout() {
  localStorage.removeItem(tokenKey);
}

// export function getCurrentUser() {
//   try {
//     const jwt = localStorage.getItem(tokenKey);
//     return jwtDecode(jwt);
//   } catch (ex) {
//     return null;
//   }
// }

export default {
  login,
  logout,
  //getCurrentUser,
};
