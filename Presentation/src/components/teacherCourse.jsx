import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import { toast } from "react-toastify";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import axios from "axios";
import "./css/teacherCourse.css";

const TeacherCourse = () => {
  const [teacherData, setTeacherData] = useState([]);
  const [teacherName, setTeacherName] = useState("");
  const [selectedCourses, setSelectedCourses] = useState([]);
  const history = useHistory();

  const getTokken = localStorage.getItem("token");

  const getTeacherData = async () => {
    try {
      await axios
        .get("https://20.204.30.1/api/cds/teacher/view_teaching_course", {
          headers: {
            "X-Access-Token": getTokken,
          },
        })
        .then((response) => {
          setTeacherData(response.data.data);
          // setTeacherName(teacherData[0].teacherName);
        });
      // setTeacherData(teacherBulkData.data.data);
      // console.log(teacherData);
      // setTeacherName(teacherData[0].teacherName);
      // console.log(teacherName);
    } catch (ex) {
      toast.error(ex);
    }
  };

  const handleOnClick = (courseData) => {
    setSelectedCourses(courseData);
  };

  const nextPage = () => {
    history.push({
      pathname: "/course/course-details",
      state: {
        selectedCourses: selectedCourses,
      },
    });
  };

  useEffect(() => {
    if (selectedCourses.length != 0) {
      nextPage();
    }
  }, [selectedCourses]);

  useEffect(() => {
    getTeacherData();
  }, []);

  useEffect(() => {
    if (teacherData.length != 0) {
      setTeacherName(teacherData[0].teacherName);
    }
  });

  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading">{teacherName}</h1>
        <p className="para">You are teaching the following courses:</p>

        {teacherData.map((courseData) => (
          <button
            type="button"
            className="course-btn"
            onClick={() => handleOnClick(courseData)}
          >
            {courseData.courseName} ({courseData.courseCode}) ( Section:{" "}
            {courseData.sectionName})
          </button>
        ))}
      </div>
      <Footer />
    </>
  );
};

export default TeacherCourse;
