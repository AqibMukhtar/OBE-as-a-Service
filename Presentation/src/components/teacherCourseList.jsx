import React from "react";
import RealNavbar from "./realNavbar";
import TeacherCourse from "./teacherCourse";
import Footer from "./footer";
import "./css/navbar.css";

const TeacherCourseList = (props) => {
  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <TeacherCourse />
      </div>
      <Footer />
    </>
  );
};

export default TeacherCourseList;
