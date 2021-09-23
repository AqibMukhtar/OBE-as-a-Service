import React, { useEffect } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { useState } from "react";
import { Button } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import { useHistory, useLocation } from "react-router";
import "./css/addAssessmentTool.css";

const getTokken = localStorage.getItem("token");

const DeleteAssessmentToolForm = () => {
  const [courseType, setCourseType] = useState("");
  const location = useLocation();
  const history = useHistory();
  const toolType = location.state.toolType;
  const handle = location.state.isPractical;

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
    cloName: location.state.cloName,
  };

  //Post Request
  const handleDelete = () => {
    if (
      (toolType === "sessional" ||
        toolType === "Sessional" ||
        toolType === "SESSIONAL") &&
      handle === 0
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/delete/sessional/theory/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            if (response.data.data[0].Success === 1) {
              toast.success(response.data.data[0].Message);
              history.push({
                pathname: "/courses/course-detail/assessment-tools",
              });
            }

            if (response.data.data[0].Success === 0)
              toast.error(response.data.data[0].Message);
          },
          (error) => {
            toast.error(error);
          }
        );
    }
    if (
      (toolType === "final" || toolType === "Final" || toolType === "FINAL") &&
      handle === 0
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/delete/final/theory/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            if (response.data.data[0].Success === 1) {
              toast.success(response.data.data[0].Message);
              history.push({
                pathname: "/courses/course-detail/assessment-tools",
              });
            }

            if (response.data.data[0].Success === 0)
              toast.error(response.data.data[0].Message);
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
      handle === 1
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/delete/sessional/practical/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            if (response.data.data[0].Success === 1) {
              toast.success(response.data.data[0].Message);
              history.push({
                pathname: "/courses/course-detail/assessment-tools",
              });
            }

            if (response.data.data[0].Success === 0)
              toast.error(response.data.data[0].Message);
          },
          (error) => {
            toast.error(error);
          }
        );
    }

    if (
      (toolType === "final" || toolType === "Final" || toolType === "FINAL") &&
      handle === 1
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/delete/final/practical/",
          data,
          axiosHeader
        )
        .then(
          (response) => {
            if (response.data.data[0].Success === 1) {
              toast.success(response.data.data[0].Message);
              history.push({
                pathname: "/courses/course-detail/assessment-tools",
              });
            }

            if (response.data.data[0].Success === 0)
              toast.error(response.data.data[0].Message);
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
    console.log(courseType);
  };

  useEffect(() => {
    handleCourseType();
  }, [handle]);

  return (
    <>
      <div className="add-background">
        <div className="container mt-4">
          <div className="add-center">
            <h2>Delete Assessment Tool</h2>
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
                  <label className="add-login-label">Total Marks </label>
                  <br></br>
                  <input
                    defaultValue={location.state.totalMarks}
                    disabled
                    id="totalMarks"
                    name="totalMarks"
                    className="add-txt-field-input"
                  />
                  <br></br>
                </div>
              </div>
              <DialogActions>
                <Button onClick={handleCancel} className="dialog-button">
                  Cancel
                </Button>{" "}
                &nbsp;&nbsp;&nbsp;&nbsp;
                <Button className="dialog-button" onClick={handleDelete}>
                  Delete
                </Button>
              </DialogActions>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default DeleteAssessmentToolForm;
