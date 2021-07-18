import React from 'react';
import Navbar from './navbar';
import TeacherCourse from './teacherCourse';
import Footer from './footer';

const CoursePage = () => {
    return (  
        <React.Fragment>
            <Navbar/>
            <TeacherCourse/>
            <Footer/>            
        </React.Fragment>
    );
}
 
export default CoursePage;