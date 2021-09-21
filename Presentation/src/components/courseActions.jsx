import React from "react";
import { useLocation } from "react-router";
import { useHistory } from "react-router-dom";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/courseActions.css";

const CourseActions = () => {
  const location = useLocation();
  const history = useHistory();

  const handleOnClickCLO = () => {
    history.push({
      pathname: "/course/course-detail/clo",
      state: {
        programId: location.state.selectedCourses.programId,
        programName: location.state.selectedCourses.programName,
        courseId: location.state.selectedCourses.courseId,
        batchId: location.state.selectedCourses.batchId,
        courseName: location.state.selectedCourses.courseName,
        courseCode: location.state.selectedCourses.courseCode,
        sectionName: location.state.selectedCourses.sectionName,
      },
    });
  };

  const handleOnClickAssessmentTool = () => {
    history.push({
      pathname: "/course/course-detail/assessment-tools",
      state: {
        courseName: location.state.selectedCourses.courseName,
        isPractical: location.state.selectedCourses.isPractical,
        programName: location.state.selectedCourses.programName,
        courseCode: location.state.selectedCourses.courseCode,
        programId: location.state.selectedCourses.programId,
        courseId: location.state.selectedCourses.courseId,
        batchId: location.state.selectedCourses.batchId,
        sectionName: location.state.selectedCourses.sectionName,
      },
    });
  };

  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">
          {location.state.selectedCourses.courseName} (
          {location.state.selectedCourses.courseCode})
        </h2>
        <button type="button" className="course-btn" onClick={handleOnClickCLO}>
          Course Learning Outcomes (CLOs)
        </button>
        <button
          type="button"
          className="course-btn"
          onClick={handleOnClickAssessmentTool}
        >
          Assessment Tools
        </button>
      </div>
      <Footer />
    </>
  );
};

export default CourseActions;
