import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import axios from "axios";
import "./css/teacherCourse.css";

const AddCLOCommit = () => {
  const [addRequestData, setAddRequestData] = useState([]);
  const history = useHistory();
  const getTokken = localStorage.getItem("token");

  const getAddRequestBulkData = async () => {
    try {
      await axios
        .get("https://20.204.30.1/api/cds/admin/uncommitted_clo_addition/", {
          headers: {
            "X-Access-Token": getTokken,
          },
        })
        .then((response) => {
          setAddRequestData(response.data.data);
        });
    } catch (error) {}
  };

  const handleOnClick = (requestData) => {
    history.push({
      pathname: "/add-clo-commits/form",
      state: {
        selectedRequestData: requestData,
      },
    });
  };

  useEffect(() => {
    getAddRequestBulkData();
  }, []);

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">Add CLO Requests</h2>
        {addRequestData.length === 0 ? (
          <p className="para">No add requests are pending</p>
        ) : (
          addRequestData.map((requestData) => (
            <button
              type="button"
              className="course-btn"
              onClick={() => handleOnClick(requestData)}
            >
              Add CLO Request by {requestData.obeName}
            </button>
          ))
        )}
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default AddCLOCommit;
