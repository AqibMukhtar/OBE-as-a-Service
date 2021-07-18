"use strict";

import express from "express";
import { createConnection } from "mysql";
import jwt from "jsonwebtoken";

import {
  getServicePort,
  getJWTSecret,
} from "../../API Gateway/apigatewayconfig.mjs";

const db = createConnection({
  host: "localhost",
  user: "root",
  password: "OBEaaS123",
  database: "OBE-as-a-Service",
});
db.connect((err) => {
  if (err) throw err;
  console.log("Password Authentication Service connected to the database.");
});

const app = express();
const port = getServicePort("password_auth");

app.use(express.json());

app.post("/api/password_auth/", (req, res) => {
  const {
    formData: { userName, password, type },
  } = req.body;

  switch (type) {
    case "teacher":
      db.query(
        `CALL authenticateTeacher(?,?);`,
        [userName, password],
        (err, result) => {
          if (err) res.send({});
          else if (result[0][0]["Authenticated"]) {
            const { teacherId, programId } = result[0][0];
            res.send(
              jwt.sign(
                { uid: teacherId, pid: programId, tid: 1 },
                getJWTSecret()
              )
            );
          } else res.send({});
        }
      );
      break;
    case "obecell":
      db.query(
        `CALL authenticateOBECell(?, ?);`,
        [password, userName],
        (err, result) => {
          if (err) res.send({});
          else if (result[0][0]["Authenticated"]) {
            const { obeId, programId } = result[0][0];
            res.send(
              jwt.sign({ uid: obeId, pid: programId, tid: 2 }, getJWTSecret())
            );
          } else res.send({});
        }
      );
      break;
    case "admin":
      db.query(
        `CALL authenticateAdmin(?, ?);`,
        [password, userName],
        (err, result) => {
          if (err || !result[0][0]["Authenticated"]) res.send({});
          else {
            const { adminId, programId } = result[0][0];
            res.send(
              jwt.sign({ uid: adminId, pid: programId, tid: 3 }, getJWTSecret())
            );
          }
        }
      );
      break;
    case "student":
      db.query(
        `CALL authenticateStudent(?, ?);`,
        [password, userName],
        (err, result) => {
          if (err || !result[0][0]["Authenticated"]) res.send({});
          else {
            const { studentId, programId } = result[0][0];
            res.send(
              jwt.sign(
                { uid: studentId, pid: programId, tid: 4 },
                getJWTSecret()
              )
            );
          }
        }
      );
      break;
    default:
      res.send({});
  }

  // res.send({ authenticated: true });
  // console.log(req.body.formData);
});

app.listen(port, () => {
  console.log("Password Authentication Service is running on port:", port);
});

process.on("exit", (code) => {
  db.end();
  console.log(`Password Authentication Service exiting with status ${code}`);
});
