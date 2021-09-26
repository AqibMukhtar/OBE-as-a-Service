import React, { useEffect, useState } from "react";
import { useHistory, useLocation } from "react-router";
import axios from "axios";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/teacherCourse.css";

const getTokken = localStorage.getItem("token");

const DeleteAssessmentTool = () => {
  const history = useHistory();
  const location = useLocation();
  const [assessmentToolList, setAssessmentToolList] = useState([]);
  const [selectedAssessmentTool, setSelectedAssessmentTool] = useState([]);

  const getAssessmentToolData = async () => {
    try {
      const AssessmentToolList = await axios.get(
        "https://20.204.30.1/api/cds/teacher/view_assessment_tools/?courseId=" +
          location.state.courseId +
          "&batchId=" +
          location.state.batchId +
          "&programId=" +
          location.state.programId,
        {
          headers: {
            "X-Access-Token": getTokken,
          },
        }
      );
      setAssessmentToolList(AssessmentToolList.data.data);
    } catch (error) {}
  };

  //When click on any assessment tool
  const handleDeleteButton = (toolData) => {
    setSelectedAssessmentTool(toolData);
  };

  useEffect(() => {
    if (selectedAssessmentTool.length != 0) {
      afterSelectionNextForm();
      console.log(selectedAssessmentTool);
    }
  }, [selectedAssessmentTool]);

  const afterSelectionNextForm = () => {
    console.log(selectedAssessmentTool.toolName);
    history.push({
      pathname:
        "/course/course-detail/assessment-tool/delete-assessment-tool-form",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
        sectionName: location.state.sectionName,
        programName: location.state.programName,
        isPractical: location.state.isPractical,
        toolType: selectedAssessmentTool.Type,
        toolName: selectedAssessmentTool.toolName,
        cloName: selectedAssessmentTool.cloName,
        totalMarks: selectedAssessmentTool.totalMarks,
      },
    });
  };
  useEffect(() => {
    getAssessmentToolData();
  }, []);

  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading">
          {location.state.courseName} ({location.state.courseCode})
        </h1>
        <p className="para">
          You have defined the following assessment tools for this course:
        </p>
        {assessmentToolList.map((toolData) => (
          <button
            type="button"
            className="course-btn"
            onClick={() => handleDeleteButton(toolData)}
          >
            {toolData.toolName}
          </button>
        ))}
      </div>
      <Footer />
    </>
  );
};

export default DeleteAssessmentTool;
