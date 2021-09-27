import React, { useEffect, useState } from "react";
import { useHistory, useLocation } from "react-router";
import axios from "axios";
import { toast } from "react-toastify";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/teacherCourse.css";

const EditAssessmentTool = () => {
  const history = useHistory();
  const location = useLocation();
  const nonConductedAssessment = [];
  const [assessmentToolList, setAssessmentToolList] = useState([]);
  const [selectedAssessmentTool, setSelectedAssessmentTool] = useState([]);
  const getTokken = localStorage.getItem("token");

  const getAssessmentToolData = async () => {
    try {
      await axios
        .get(
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
        )
        .then((response) => {
          setAssessmentToolList(response.data.data);
        });
    } catch (error) {
      toast.error(error);
    }
  };

  //Filtering
  for (let i = 0; i < assessmentToolList.length; i++) {
    if (assessmentToolList[i].isConducted === 0) {
      nonConductedAssessment.push(assessmentToolList[i]);
    }
  }

  //When click on any assessment tool
  const handleEditButton = (toolData) => {
    setSelectedAssessmentTool(toolData);
  };

  useEffect(() => {
    if (selectedAssessmentTool.length != 0) {
      afterSelectionNextForm();
    }
  }, [selectedAssessmentTool]);

  const afterSelectionNextForm = () => {
    history.push({
      pathname:
        "/course/course-detail/assessment-tool/edit-assessment-tool-form",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
        sectionName: selectedAssessmentTool.sectionName,
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
        {nonConductedAssessment.map((toolData) => (
          <button
            type="button"
            className="course-btn"
            onClick={() => handleEditButton(toolData)}
          >
            {toolData.toolName} ({toolData.sectionName})
          </button>
        ))}
      </div>
      <Footer />
    </>
  );
};

export default EditAssessmentTool;
