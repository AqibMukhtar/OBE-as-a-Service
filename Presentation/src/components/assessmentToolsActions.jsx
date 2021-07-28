import React, { Component } from 'react';
import './css/teacherCourse.css';


class AssessmentToolsActions extends Component {
    state = {  
    }

    render() { 
        return (
            <React.Fragment>
                <div>
                    <button type="button" className="course-btn">View Assessment Tools</button>
                    <button type="button" className="course-btn">Edit Assessment Tools</button>
                    <button type="button" className="course-btn">Add Assessment Tool</button>
                    <button type="button" className="course-btn">Delete Assessment Tool</button>
                </div>
            </React.Fragment>
          );
    }
}
 
export default AssessmentToolsActions