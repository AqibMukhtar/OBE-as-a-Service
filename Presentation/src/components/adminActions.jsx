import React, { useState } from "react";
import { useEffect } from "react";
import { useHistory, useLocation } from "react-router";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/teacherCourse.css";

const AdminActions = () => {
  const location = useLocation();
  const history = useHistory();
  const [programName, setProgramName] = useState("");

  const handleOnClickAddCLORequest = () => {
    history.push({
      pathname: "/add-clo-commit",
    });
  };
  const handleOnClickUpdateCLORequest = () => {
    history.push({
      pathname: "/update-clo-commit",
    });
  };
  const handleOnClickDeleteCLORequest = () => {
    history.push({
      pathname: "/delete-clo-commit",
    });
  };

  useEffect(() => {
    setProgramName("Software Engineering");
  });

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">{programName} Department</h2>
        <button
          type="button"
          onClick={handleOnClickAddCLORequest}
          className="course-btn"
        >
          Add CLO Requests
        </button>
        <button
          type="button"
          onClick={handleOnClickUpdateCLORequest}
          className="course-btn"
        >
          Update CLO Requests
        </button>
        <button
          type="button"
          onClick={handleOnClickDeleteCLORequest}
          className="course-btn"
        >
          Delete CLO Requests
        </button>
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default AdminActions;
