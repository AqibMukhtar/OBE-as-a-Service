import React, { useState } from "react";
import { useEffect } from "react";
import { useHistory, useLocation } from "react-router";
import "./css/teacherCourse.css";
import Footer from "./footer";
import RealNavbar from "./realNavbar";

const OBEcellActions = () => {
  const location = useLocation();
  const history = useHistory();
  const [programName, setProgramName] = useState("");
  const [userName, setUserName] = useState("");

  const handleOnClickAddCLO = () => {
    history.push({
      pathname: "/add-clo",
    });
  };
  const handleOnClickUpdateCLO = () => {
    history.push({
      pathname: "/update-clo",
    });
  };
  const handleOnClickDeleteCLO = () => {
    history.push({
      pathname: "/delete-clo",
    });
  };
  const handleOnClickCLORequest = () => {
    history.push({
      pathname: "/delete-clo",
    });
  };

  useEffect(() => {
    setProgramName("Software Engineering");
    setUserName("Wahabuddin Usmani");
  });

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">
          {userName} - {programName} department
        </h2>
        <button
          onClick={handleOnClickAddCLO}
          type="button"
          className="course-btn"
        >
          Add CLO
        </button>
        <button
          onClick={handleOnClickUpdateCLO}
          type="button"
          className="course-btn"
        >
          Update CLO
        </button>
        <button
          onClick={handleOnClickDeleteCLO}
          type="button"
          className="course-btn"
        >
          Delete CLO
        </button>
        <button
          onClick={handleOnClickCLORequest}
          type="button"
          className="course-btn"
        >
          CLO requests by teachers
        </button>
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default OBEcellActions;
