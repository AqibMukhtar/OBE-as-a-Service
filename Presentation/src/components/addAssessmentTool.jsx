import React, { useEffect } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { useState } from "react";
import { Button } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import { useHistory, useLocation } from "react-router";
import "./css/addAssessmentTool.css";

const getTokken = localStorage.getItem("token");

const AddAssessmentTool = () => {
  const [courseType, setCourseType] = useState("");
  const [toolType, setToolType] = useState("");
  const [toolName, setToolName] = useState("");
  const [cloName, setCloName] = useState("");
  const [totalMarks, setTotalMarks] = useState();
  const location = useLocation();
  const history = useHistory();
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
    toolName,
    cloName,
    totalMarks,
  };

  //Post Request
  const handleAdd = () => {
    if (
      (toolType === "sessional" ||
        toolType === "Sessional" ||
        toolType === "SESSIONAL") &&
      handle === 0
    ) {
      axios
        .post(
          "https://20.204.30.1/api/assessment_tool_definition/teacher/sessional/theory/",
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
      alert("Wait for API of theory final");
    }

    if (
      (toolType === "sessional" ||
        toolType === "Sessional" ||
        toolType === "SESSIONAL") &&
      handle === 1
    ) {
      alert("Wait for API of practical sessional");
    }

    if (
      (toolType === "final" || toolType === "Final" || toolType === "FINAL") &&
      handle === 1
    ) {
      alert("Wait for API of practical final");
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
      <div className="background">
        <div className="container mt-4">
          <div className="center">
            <h2>Add Assessment Tool</h2>
            <form>
              <div className="txt_field">
                <div className="form-group">
                  <label className="login_label">Program Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.programName}
                    disabled
                    id="programName"
                    name="programName"
                    className="txt_field_input"
                  />
                  <br></br>
                  <label className="login_label">BatchId</label>
                  <br></br>
                  <input
                    defaultValue={location.state.batchId}
                    disabled
                    id="batchId"
                    name="batchId"
                    className="txt_field_input"
                  />
                  <label className="login_label">Course Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.courseName}
                    disabled
                    id="courseName"
                    name="courseName"
                    className="txt_field_input"
                  />
                  <label className="login_label">Course Code </label>
                  <br></br>
                  <input
                    defaultValue={location.state.courseCode}
                    disabled
                    id="courseCode"
                    name="courseCode"
                    className="txt_field_input"
                  />
                  <br></br>
                  <label className="login_label">Course Type </label>
                  <br></br>
                  <input
                    value={courseType}
                    disabled
                    id="courseCode"
                    name="courseCode"
                    className="txt_field_input"
                  />
                  <br></br>
                  <label className="login_label">Section Name</label>
                  <br></br>
                  <input
                    defaultValue={location.state.sectionName}
                    id="sectionName"
                    name="sectionName"
                    className="txt_field_input"
                    placeholder="B"
                  />
                  <br></br>
                  <label className="login_label">Tool Type</label>
                  <br></br>
                  <input
                    value={toolType}
                    required
                    placeholder="Sessional / Final"
                    id="toolType"
                    name="toolType"
                    className="txt_field_input"
                    onChange={(e) => setToolType(e.target.value)}
                  />
                  <br></br>

                  <label className="login_label">Tool Name</label>
                  <br></br>
                  <input
                    value={toolName}
                    required
                    id="toolName"
                    name="toolName"
                    className="txt_field_input"
                    placeholder="Quiz 01"
                    onChange={(e) => setToolName(e.target.value)}
                  />
                  <br></br>
                  <label className="login_label">CLO Name</label>
                  <br></br>
                  <input
                    value={cloName}
                    required
                    placeholder="CLO-01"
                    id="cloName"
                    name="cloName"
                    className="txt_field_input"
                    onChange={(e) => setCloName(e.target.value)}
                  />
                  <br></br>
                  <label className="login_label">Total Marks </label>
                  <br></br>
                  <input
                    value={totalMarks}
                    required
                    id="totalMarks"
                    name="totalMarks"
                    className="txt_field_input"
                    placeholder="09"
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
                <Button onClick={handleAdd} className="dialog-button">
                  Add
                </Button>
              </DialogActions>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default AddAssessmentTool;
