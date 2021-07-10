import React, { Component } from 'react';
import './css/teacherCourse.css'

class courseDisplay extends Component {
    state = {  }
    render() { 
        return (
            <button type="button" className="course-btn">{this.props.courseName}  ({this.props.courseId})</button>
          );
    }
}
 
export default courseDisplay;