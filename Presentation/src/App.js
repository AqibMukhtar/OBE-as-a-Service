import React from "react";
import { Switch, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import LoginForm from "./components/loginForm";
import Logout from "./components/logout";
import Navbar from "./components/navbar";
import TeacherCourse from "./components/teacherCourse";
import CoursePage from "./components/coursePage";
import "react-toastify/dist/ReactToastify.css";
import "./App.css";


function App() {
  return (
    <React.Fragment>
      <ToastContainer />
      <div className="content">
        <Switch>
          <Route path="/" exact component={LoginForm} />
          <Route path="/login" exact component={LoginForm} />
          <Route path="/logout" exact component={Logout} />
          <Route path="/navbar" component={Navbar} />
          <Route path="/courses" component={CoursePage}/>
        </Switch>
      </div>
      <TeacherCourse />
    </React.Fragment>
  );
}

export default App;
