import React, { Component } from 'react';
import CourseClo from './courseClo';
import './css/courseActions.css';

class CourseActions extends Component {
    
            handleOnClickCLO = () => {
            this.setState({showCLO: true})
        }

        handleOnClickAssessmentTool = () => {
            this.setState({showAssessmentTool: true})
        }
    
    state = {
        showCLO: false,
        showAssessmentTool: false
      }
    render() {
        return (  
            <React.Fragment>   
            {!this.state.showCLO && !this.state.showAssessmentTool &&
                <div>
                    <h1 className="heading">{this.props.course.courseName} ({this.props.course.courseCode})</h1>
                    <button type="button" className="course-btn" onClick={this.handleOnClickCLO}>Course Learning Outcomes (CLOs)</button>
                    <button type="button" className="course-btn" onClick={this.handleOnClickAssessmentTool}>Assessment Tools</button>
                </div>
                }

            {this.state.showCLO && !this.state.showAssessmentTool &&
                <div>
                    <CourseClo
                        selectedCourse = {this.props.course}
                    />
                </div>
            }

            {!this.state.showCLO && this.state.showAssessmentTool &&
                <div>

                </div>
            }

    </React.Fragment>
        );
    }
}
 
export default CourseActions;
