import React from "react";
import axios from "axios";
import { useState, useEffect } from "react";
import { useHistory } from "react-router";
import { toast } from "react-toastify";
import { Button } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import "./css/addAssessmentTool.css";

const DeleteCLO = () => {
  const history = useHistory();
  const getTokken = localStorage.getItem("token");
  const [courseCode, setCourseCode] = useState("");
  const [courseName, setCourseName] = useState("");
  const [courseType, setCourseType] = useState("");
  const [isPractical, setIsPractical] = useState("");
  const [batchId, setBatchId] = useState("");
  const [cloName, setCloName] = useState("");
  const [deleteNotes, setDeleteNotes] = useState("");

  let axiosHeader = {
    headers: {
      "X-Access-Token": getTokken,
    },
  };

  const data = {
    courseCode: courseCode,
    courseName: courseName,
    isPractical: isPractical,
    batchId: batchId,
    cloName: cloName,
    deleteNotes: deleteNotes,
  };

  const handleDelete = () => {
    axios
      .post(
        "https://20.204.30.1/api/clo_request/obe_cell/delete_clo",
        data,
        axiosHeader
      )
      .then(
        (response) => {
          try {
            if (response.data.data.Success === 1) {
              toast.success(response.data.data.Message);
              history.push({
                pathname: "/obe-cell",
              });
            } else if (response.data.data.Success === 0) {
              toast.error(response.data.data.Message);
            }
          } catch (ex) {
            toast.error("Invalid request");
          }
        },
        (error) => {
          toast.error(error);
        }
      );
  };

  const handleCancel = () => {
    history.push({
      pathname: "/obe-cell",
    });
  };

  const handleCourseType = () => {
    if (courseType === "practical") setIsPractical("1");
    else if (courseType === "Practical") setIsPractical("1");
    else if (courseType === "PRACTICAL") setIsPractical("1");
    else setIsPractical("0");
  };

  useEffect(() => {
    handleCourseType();
  });

  return (
    <React.Fragment>
      <div className="add-background">
        <div className="container mt-4">
          <div className="add-center">
            <h2>Delete CLO</h2>
            <form>
              <div className="add-txt-field">
                <div>
                  <label className="add-login-label">Course Code </label>
                  <br></br>
                  <input
                    required
                    placeholder="SE-301"
                    id="courseCode"
                    name="courseCode"
                    className="add-txt-field-input"
                    value={courseCode}
                    onChange={(e) => setCourseCode(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">Course Name</label>
                  <br></br>
                  <input
                    required
                    placeholder="Software Quality Engineering"
                    id="courseName"
                    name="courseName"
                    className="add-txt-field-input"
                    value={courseName}
                    onChange={(e) => setCourseName(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">Course Type </label>
                  <br></br>
                  <input
                    required
                    placeholder="Theory / Practical"
                    id="courseType"
                    name="courseType"
                    className="add-txt-field-input"
                    value={courseType}
                    onChange={(e) => setCourseType(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">Batch Id</label>
                  <br></br>
                  <input
                    required
                    placeholder="2021"
                    id="batchId"
                    name="batchId"
                    className="add-txt-field-input"
                    value={batchId}
                    onChange={(e) => setBatchId(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">CLO Name</label>
                  <br></br>
                  <input
                    required
                    placeholder="CLO-01"
                    id="cloName"
                    name="cloName"
                    className="add-txt-field-input"
                    value={cloName}
                    onChange={(e) => setCloName(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">Delete Notes</label>
                  <br></br>
                  <input
                    id="deleteNotes"
                    placeholder="optional"
                    name="deleteNotes"
                    className="add-txt-field-input"
                    value={deleteNotes}
                    onChange={(e) => setDeleteNotes(e.target.value)}
                  />
                </div>
              </div>
              <DialogActions>
                <Button onClick={handleCancel} className="dialog-button">
                  Cancel
                </Button>{" "}
                &nbsp;&nbsp;&nbsp;&nbsp;
                <Button
                  disabled={
                    !courseCode ||
                    !courseName ||
                    !courseType ||
                    !isPractical ||
                    !batchId ||
                    !cloName
                  }
                  onClick={handleDelete}
                  className="dialog-button"
                >
                  Delete
                </Button>
              </DialogActions>
            </form>
          </div>
        </div>
      </div>
    </React.Fragment>
  );
};

export default DeleteCLO;
