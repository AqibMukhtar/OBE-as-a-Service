import React, { Component } from "react";
import CourseDisplay from "./courseDisplay";
import "./css/teacherCourse.css";
import axios from "axios";

const getTokken = localStorage.getItem("token");

class TeacherCourse extends Component {
  getData = () => {
    axios
      .get("https://20.204.30.1/api/cds/teacher/view_teaching_course", {
        headers: {
          "X-Access-Token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjE4LCJwaWQiOjEsInRpZCI6MSwiaWF0IjoxNjI2NTg5OTMwfQ.3-22BOARRhmel-yVLRjCbR4Cf4fL91Zu1m5scjtFk2Q",
        },
      })
      .then((response) => {
        const data = response.data.data;
        this.setState({ courses: data });
        this.setName();
        console.log(data);
      })
      .catch((error) => console.log(error));
  };

  componentDidMount() {
    this.getData();
  }

  setName = () => {
    const teacher = this.state.courses[0];
    const teacherName = teacher.teacherName;
    this.setState({ teacherName });
  };

  state = {
    teacherName: "",
    courses: [],
  };
  render() {
    return (
      <React.Fragment>
        <div>
          <h1 className="heading">{this.state.teacherName}</h1>
          <p className="para">You are teaching the following courses:</p>
          {this.state.courses.map((course) => (
            <CourseDisplay
              key={course.courseCode}
              courseId={course.courseCode}
              courseName={course.courseName}
            />
          ))}
        </div>
      </React.Fragment>
    );
  }
}

export default TeacherCourse;
