import React, { Component } from "react";
import "./css/teacherCourse.css";

class OBECellActions extends Component {
    
    state = {
        ProgramName: "Software Engineering"
      }

    render() {
        return (
            <React.Fragment>
                <h1 className="heading">OBE Cell - {this.state.ProgramName}</h1>
                <button type="button" className="course-btn">Add CLO</button>
                <button type="button" className="course-btn">Update CLO</button>
                <button type="button" className="course-btn">Delete CLO</button>
                <button type="button" className="course-btn">CLO Requests By Teachers</button>
            </React.Fragment>
            );
    }
}

export default OBECellActions;


