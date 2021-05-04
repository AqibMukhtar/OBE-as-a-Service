import http from "./httpService";
import { apiUrl } from "../config.json";
import jwtDecode from "jwt-decode";

const apiEndPoint = apiUrl + "/auth";

export function login(username, password, type) {
  return http.post(apiEndPoint, { username, password, type });
}

export function getCurrentUser() {
  try {
    const jwt = localStorage.getItem("token");
    const user = jwtDecode(jwt);
    return user;
  } catch (ex) {
    return null;
  }
}
