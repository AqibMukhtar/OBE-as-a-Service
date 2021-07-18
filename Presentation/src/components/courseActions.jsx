import React, { Component } from 'react';
import './css/courseActions.css';

class CourseActions extends Component {
    state = {
        courseName: "Software Engineering",
        courseCode: "SE-207"
    }
    render() { 
        return (
            <React.Fragment>
                <div>
                    <h1 className="heading">{this.state.courseName} ({this.state.courseCode})</h1>
                </div>
                <div>
                <button type="button" className="course-btn">Course Learning Outcomes (CLOs)</button>
                <button type="button" className="course-btn">Assessment Tools</button>
                </div>
            </React.Fragment>
        );
    }
}

export default CourseActions;