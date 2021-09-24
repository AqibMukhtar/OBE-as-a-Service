import React from "react";
import { Switch, Route } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import LoginForm from "./components/loginForm";
import Logout from "./components/logout";
import Navbar from "./components/navbar";
import CourseActions from "./components/courseActions";
import CourseClo from "./components/courseClo";
import AssessmentToolsActions from "./components/assessmentToolsActions";
import ViewAssessmentTool from "./components/viewAssessmentTool";
import AddAssessmentTool from "./components/addAssessmentTool";
import EditAssessmentTool from "./components/editAssessmentToolList";
import DeleteAssessmentTool from "./components/deleteAssessmentToolList";
import DeleteAssessmentToolForm from "./components/deleteAssessmentToolForm";
import EditAssessmentToolForm from "./components/editAssessmentToolForm";
import GradeAssessmentTool from "./components/gradeAssessmentToolList";
import FutureUpgradeAlert from "./components/futureUpgradeAlert";
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
          <Route path="/courses" component={Navbar} />
          <Route path="/course/course-details" component={CourseActions} />
          <Route path="/course/course-detail/clo" component={CourseClo} />
          <Route
            path="/course/course-detail/assessment-tools"
            component={AssessmentToolsActions}
          />
          <Route
            path="/course/course-detail/assessment-tool/view-assessment-tool"
            component={ViewAssessmentTool}
          />
          <Route
            path="/course/course-detail/assessment-tool/add-assessment-tool"
            component={AddAssessmentTool}
          />
          <Route
            path="/course/course-detail/assessment-tool/edit-assessment-tool"
            component={EditAssessmentTool}
          />
          <Route
            path="/course/course-detail/assessment-tool/delete-assessment-tool"
            component={DeleteAssessmentTool}
          />
          <Route
            path="/course/course-detail/assessment-tool/delete-assessment-tool-form"
            component={DeleteAssessmentToolForm}
          />
          <Route
            path="/course/course-detail/assessment-tool/edit-assessment-tool-form"
            component={EditAssessmentToolForm}
          />
          <Route
            path="/course/course-detail/assessment-tool/grade-assessment-tool"
            component={GradeAssessmentTool}
          />
          <Route
            path="/course/course-detail/assessment-tool/grade-assessment-tools/grade"
            component={FutureUpgradeAlert}
          />
        </Switch>
      </div>
    </React.Fragment>
  );
}

export default App;
