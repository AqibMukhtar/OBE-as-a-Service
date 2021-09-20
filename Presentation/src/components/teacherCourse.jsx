import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import axios from "axios";
import "./css/teacherCourse.css";

const getTokken = localStorage.getItem("token");

const TeacherCourse = () => {
  const [teacherData, setTeacherData] = useState([]);
  const [teacherName, setTeacherName] = useState("");
  const [selectedCourses, setSelectedCourses] = useState([]);
  const history = useHistory();

  const getTeacherData = async () => {
    try {
      const teacherBulkData = await axios.get(
        "https://20.204.30.1/api/cds/teacher/view_teaching_course",
        {
          headers: {
            "X-Access-Token": getTokken,
          },
        }
      );
      setTeacherData(teacherBulkData.data.data);
      console.log(teacherData);
      setTeacherName(teacherData[0].teacherName);
      console.log(teacherName);
    } catch (error) {}
  };

  const handleOnClick = (courseData) => {
    console.log("this is handle on click");
    console.log(courseData);
    setSelectedCourses(courseData);
    console.log("this is selected courses");
    console.log(selectedCourses);
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
  }, [teacherData]);

  return (
    <>
      <div>
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
    </>
  );
};

export default TeacherCourse;
