import React, { Component } from 'react';
import './css/teacherCourse.css'

class CourseDisplay extends Component {
    state = {  }
    render() { 
        return (
            <button type="button" className="course-btn">{this.props.courseName}  ({this.props.courseId})</button>
          );
    }
}
 
export default CourseDisplay;