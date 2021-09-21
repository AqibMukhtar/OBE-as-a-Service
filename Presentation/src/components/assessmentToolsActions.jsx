import React from "react";
import { useHistory, useLocation } from "react-router";
import "./css/teacherCourse.css";
import Footer from "./footer";
import RealNavbar from "./realNavbar";

const AssessmentToolsActions = () => {
  const location = useLocation();
  const history = useHistory();

  //View Assessment Tool Button
  const handleViewAssessmentTool = () => {
    history.push({
      pathname: "/course/course-detail/assessment-tool/view-assessment-tool",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
      },
    });
  };

  //Add Assessment Tool Button
  const handleAddAssessmentTool = () => {
    history.push({
      pathname: "/course/course-detail/assessment-tool/add-assessment-tool",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
        sectionName: location.state.sectionName,
        programName: location.state.programName,
        isPractical: location.state.isPractical,
      },
    });
  };

  //Edit Assessment Tool Button
  const handleEditAssessmentTool = () => {
    history.push({
      pathname: "/course/course-detail/assessment-tool/edit-assessment-tool",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
        sectionName: location.state.sectionName,
        programName: location.state.programName,
        isPractical: location.state.isPractical,
      },
    });
  };

  //Delete Assessment Tool Button
  const handleDeleteAssessmentTool = () => {
    history.push({
      pathname: "/course/course-detail/assessment-tool/delete-assessment-tool",
      state: {
        programId: location.state.programId,
        batchId: location.state.batchId,
        courseId: location.state.courseId,
        courseName: location.state.courseName,
        courseCode: location.state.courseCode,
        sectionName: location.state.sectionName,
        programName: location.state.programName,
        isPractical: location.state.isPractical,
      },
    });
  };

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">
          {location.state.courseName} ({location.state.courseCode})
        </h2>
        <button
          type="button"
          className="course-btn"
          onClick={handleViewAssessmentTool}
        >
          View Assessment Tools
        </button>
        <button
          type="button"
          className="course-btn"
          onClick={handleAddAssessmentTool}
        >
          Add Assessment Tool
        </button>
        <button
          type="button"
          className="course-btn"
          onClick={handleEditAssessmentTool}
        >
          Edit Assessment Tools
        </button>
        <button
          type="button"
          className="course-btn"
          onClick={handleDeleteAssessmentTool}
        >
          Delete Assessment Tool
        </button>
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default AssessmentToolsActions;
