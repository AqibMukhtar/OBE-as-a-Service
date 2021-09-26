import React, { useState } from "react";
import axios from "axios";
import { useEffect } from "react";
import { useHistory } from "react-router";
import Footer from "./footer";
import RealNavbar from "./realNavbar";
import "./css/teacherCourse.css";

const AdminActions = () => {
  const history = useHistory();
  const [programName, setProgramName] = useState("");
  const [adminData, setAdminData] = useState("");
  const getTokken = localStorage.getItem("token");

  const getData = async () => {
    try {
      await axios
        .get("https://20.204.30.1/api/cds/view_name", {
          headers: {
            "X-Access-Token": getTokken,
          },
        })
        .then((response) => {
          setAdminData(response.data.data);
        });
    } catch (error) {}
  };

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
    getData();
  }, []);

  useEffect(() => {
    if (adminData.length != 0) {
      setProgramName(adminData[0].programName);
    }
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
