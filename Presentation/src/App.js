import React from "react";
import { Switch, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import LoginForm from "./components/loginForm";
import Logout from "./components/logout";
import Navbar from "./components/navbar";
import TeacherCourse from "./components/teacherCourse";
import CoursePage from "./components/coursePage";
import CourseActions from "./components/courseActions";
import OBECellActions from "./components/OBECellActions";
import AddCLO from "./components/addCLO";
import "react-toastify/dist/ReactToastify.css";
import "./App.css";
import AssessmentToolsActions from "./components/assessmentToolsActions";
import UpdateCLO from "./components/updateCLO";
import DeleteCLO from "./components/deleteCLO";


function App() {
  return (
    <React.Fragment>
      {/* <ToastContainer />
      <div className="content">
        <Switch>
          <Route path="/" exact component={LoginForm} />
          <Route path="/login" exact component={LoginForm} />
          <Route path="/logout" exact component={Logout} />
          <Route path="/courses" component={Navbar} />
          <Route path="/actions" component={CourseActions}/>
        </Switch>
      </div> */}
      <DeleteCLO/>
    </React.Fragment>
  );
}

export default App;
