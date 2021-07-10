import React, { Component } from 'react';
import courseDisplay from './courseDisplay';
import './css/teacherCourse.css';

class teacherCourse extends Component {
    state = {
        teacherName: "Asma Khan",
        courses: [
            {
                name: "Object Oriented Programming",
                id: "SE-205"
            },
            {
                name: "Software Engineering",
                id: "SE-207"
            },
            {
                name: "Programming Language",
                id: "SE-107"
            },
            {
                name: "Data Structures",
                id: "SE-104"
            }
        ]
      }
    render() { 
        return (
            <React.Fragment>
                <div>
                    <h1 className="heading">{this.state.teacherName}</h1>
                    <p className="para">You are teaching the following courses:</p>
                    {this.state.courses.map(course => (
                    <courseDisplay key={course.id} courseId={course.id} courseName={course.name} />
                    ))}
                </div>
            </React.Fragment>
          );
    }
}
 
export default teacherCourse;