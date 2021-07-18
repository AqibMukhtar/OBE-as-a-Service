import React from "react";
<<<<<<< HEAD
import { Switch, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import LoginForm from "./components/loginForm";
import Logout from "./components/logout";
import Navbar from "./components/navbar";
import "react-toastify/dist/ReactToastify.css";
=======
// import { Switch, Route } from "react-router-dom";
// import LoginForm from "./components/loginForm";
// import Logout from "./components/logout";
// import Navbar from "./components/navbar";
import TeacherCourse from "./components/teacherCourse"
>>>>>>> 255bcee42c2f85e7d3a6b5ab36208e7616d340b2
import "./App.css";

function App() {
  return (
    <React.Fragment>
<<<<<<< HEAD
      <ToastContainer />
      <div className="content">
=======
      {/* <div className="content">
>>>>>>> 255bcee42c2f85e7d3a6b5ab36208e7616d340b2
        <Switch>
          <Route path="/" exact component={LoginForm} />
          <Route path="/login" exact component={LoginForm} />
          <Route path="/logout" exact component={Logout} />
          <Route path="/navbar" component={Navbar} />
        </Switch>
      </div> */}
      <TeacherCourse/>
    </React.Fragment>
  );
}

export default App;
