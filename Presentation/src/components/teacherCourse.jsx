import React, { Component } from "react";
import CourseActions from "./courseActions";
import "./css/teacherCourse.css";
import axios from "axios";


const getTokken = localStorage.getItem("token");

class TeacherCourse extends Component {
  getData = () => {
    axios
      .get("https://20.204.30.1/api/cds/teacher/view_teaching_course", {
        headers: {
          "X-Access-Token": getTokken
        },
      })
      .then((response) => {
        const data = response.data.data;
        this.setState({ courses: data });
        this.setName();
        console.log(this.state.courses);
        console.log(getTokken);
      })
      .catch((error) => {
        console.log(error);
        console.log(error.response.status);
        const expectedError =
        error.response.status >= 300 ||
        error.response.status < 200;
        this.setState({expectedError});
      if (expectedError) {
        alert("An error occurred");
        window.location="/logout";
      }
      return Promise.reject(error);
      })
  }


  componentDidMount() {
    this.getData();
  }

  setName = () => {
    const teacher = this.state.courses[0];
    const teacherName = teacher.teacherName;
    this.setState({ teacherName });
  }

  handleOnClick = (course) => {
    this.setState({showActions: true});
    this.setState({selectedCourse: course})
  }

  state = {
    expectedError: false,
    showActions: false,
    teacherName: "",
    courses: [],
    selectedCourse: []
  }
  render() {
    return (
      <React.Fragment>
          { !this.state.expectedError && !this.state.showActions &&
            <div>
              <h1 className="heading">{this.state.teacherName}</h1>
              <p className="para">You are teaching the following courses:</p>
              {this.state.courses.map((course) => <button type="button" className="course-btn" onClick={() => this.handleOnClick(course)}>{course.courseName} ({course.courseCode})</button>
            )}
            </div>
          }
          { !this.state.expectedError && this.state.showActions &&
            <div>
                <CourseActions
                  course = {this.state.selectedCourse}
                />
            </div>
          }
      </React.Fragment>
    );
  }
}

export default TeacherCourse;
