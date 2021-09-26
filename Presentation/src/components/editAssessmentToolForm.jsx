import React, { useEffect } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { useState } from "react";
import { Button } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import { useHistory, useLocation } from "react-router";
import "./css/addAssessmentTool.css";

const getTokken = localStorage.getItem("token");

const EditAssessmentToolForm = () => {
  const location = useLocation();
  const history = useHistory();
  const handle = location.state.isPractical;
  const [courseType, setCourseType] = useState("");
  const [newToolName, setnewToolName] = useState(location.state.toolName);
  const [newCloName, setNewCloName] = useState(location.state.cloName);
  const [totalMarks, setTotalMarks] = useState(location.state.totalMarks);
  const toolType = location.state.toolType;
  //Header to be send through post request
  let axiosHeader = {
    headers: {
      "X-Access-Token": getTokken,
    },
  };

  //Date to be send through post request
  const data = {
    programName: location.state.programName,
    batchId: location.state.batchId,
    courseName: location.state.courseName,
    courseCode: location.state.courseCode,
    sectionName: location.state.sectionName,
    toolName: location.state.toolName,
    newToolName,
    cloName: location.state.cloName,
    newCloName,
    totalMarks,
  };

  //Post Request
  const handleUpdate = () => {
    if (
      (toolType === "sessional" ||
        toolType === "Sessional" ||
        toolType === "SESSIONAL") &&
      location.state.isPractical === 0
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/update/sessional/theory/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            try {
              if (response.data.data[0].Success === 1) {
                toast.success(response.data.data[0].Message);
                history.push({
                  pathname: "/courses/course-detail/assessment-tools",
                });
              } else if (response.data.data[0].Success === 0) {
                toast.error(response.data.data[0].Message);
              }
            } catch (ex) {
              toast.error("Invalid request");
            }
          },
          (error) => {
            toast.error(error);
          }
        );
    }
    if (
      (toolType === "final" || toolType === "Final" || toolType === "FINAL") &&
      location.state.isPractical === 0
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/update/final/theory/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            try {
              if (response.data.data[0].Success === 1) {
                toast.success(response.data.data[0].Message);
                history.push({
                  pathname: "/courses/course-detail/assessment-tools",
                });
              } else if (response.data.data[0].Success === 0) {
                toast.error(response.data.data[0].Message);
              }
            } catch (ex) {
              toast.error("Invalid request");
            }
          },
          (error) => {
            toast.error(error);
          }
        );
    }

    if (
      (toolType === "sessional" ||
        toolType === "Sessional" ||
        toolType === "SESSIONAL") &&
      location.state.isPractical === 1
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/update/sessional/practical/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            try {
              if (response.data.data[0].Success === 1) {
                toast.success(response.data.data[0].Message);
                history.push({
                  pathname: "/courses/course-detail/assessment-tools",
                });
              } else if (response.data.data[0].Success === 0) {
                toast.error(response.data.data[0].Message);
              }
            } catch (ex) {
              toast.error("Invalid request");
            }
          },
          (error) => {
            toast.error(error);
          }
        );
    }

    if (
      (toolType === "final" || toolType === "Final" || toolType === "FINAL") &&
      location.state.isPractical === 1
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/update/final/practical/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            try {
              if (response.data.data[0].Success === 1) {
                toast.success(response.data.data[0].Message);
                history.push({
                  pathname: "/courses/course-detail/assessment-tools",
                });
              } else if (response.data.data[0].Success === 0) {
                toast.error(response.data.data[0].Message);
              }
            } catch (ex) {
              toast.error("Invalid request");
            }
          },
          (error) => {
            toast.error(error);
          }
        );
    }
  };

  const handleCancel = () => {
    history.push({
      pathname: "/courses/course-detail/assessment-tools",
    });
  };

  const handleCourseType = () => {
    {
      handle === 1 ? setCourseType("Practical") : setCourseType("Theory");
    }
  };

  useEffect(() => {
    handleCourseType();
  }, [handle]);

  return (
    <>
      <div className="add-background">
        <div className="container mt-4">
          <div className="add-center">
            <h2>Update Assessment Tool</h2>
            <form>
              <div className="add-txt-field">
                <div>
                  <label className="add-login-label">Program Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.programName}
                    disabled
                    id="programName"
                    name="programName"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">BatchId</label>
                  <br></br>
                  <input
                    defaultValue={location.state.batchId}
                    disabled
                    id="batchId"
                    name="batchId"
                    className="add-txt-field-input"
                  />
                  <label className="add-login-label">Course Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.courseName}
                    disabled
                    id="courseName"
                    name="courseName"
                    className="add-txt-field-input"
                  />
                  <label className="add-login-label">Course Code </label>
                  <br></br>
                  <input
                    defaultValue={location.state.courseCode}
                    disabled
                    id="courseCode"
                    name="courseCode"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">Course Type </label>
                  <br></br>
                  <input
                    defaultValue={courseType}
                    disabled
                    id="courseCode"
                    name="courseCode"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">Section Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.sectionName}
                    disabled
                    id="sectionName"
                    name="sectionName"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">Tool Type</label>
                  <br></br>
                  <input
                    defaultValue={location.state.toolType}
                    disabled
                    id="toolType"
                    name="toolType"
                    className="add-txt-field-input"
                  />
                  <br></br>

                  <label className="add-login-label">Tool Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.toolName}
                    disabled
                    id="toolName"
                    name="toolName"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">New Tool Name</label>
                  <br></br>
                  <input
                    value={newToolName}
                    id="newToolName"
                    name="newToolName"
                    className="add-txt-field-input"
                    placeholder="Assignment 02"
                    onChange={(e) => setnewToolName(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">CLO Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.cloName}
                    disabled
                    id="cloName"
                    name="cloName"
                    className="add-txt-field-input"
                  />
                  <br></br>
                  <label className="add-login-label">New CLO Name </label>
                  <br></br>
                  <input
                    value={newCloName}
                    id="newCloName"
                    name="newCloName"
                    className="add-txt-field-input"
                    placeholder="CLO-02"
                    onChange={(e) => setNewCloName(e.target.value)}
                  />
                  <br></br>
                  <label className="add-login-label">Total Marks </label>
                  <br></br>
                  <input
                    value={totalMarks}
                    id="totalMarks"
                    name="totalMarks"
                    className="add-txt-field-input"
                    onChange={(e) => setTotalMarks(e.target.value)}
                  />
                  <br></br>
                </div>
              </div>
              <DialogActions>
                <Button onClick={handleCancel} className="dialog-button">
                  Cancel
                </Button>{" "}
                &nbsp;&nbsp;&nbsp;&nbsp;
                <Button
                  className="dialog-button"
                  disabled={!newCloName || !totalMarks || !newToolName}
                  onClick={handleUpdate}
                >
                  Update
                </Button>
              </DialogActions>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default EditAssessmentToolForm;
