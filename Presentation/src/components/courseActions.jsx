import React, { Component } from 'react';
import './css/courseActions.css';

class courseActions extends Component {
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
                <button type="button" className="course-btn">Request For CLO Management</button>
                </div>
            </React.Fragment>
        );
    }
}

export default courseActions;