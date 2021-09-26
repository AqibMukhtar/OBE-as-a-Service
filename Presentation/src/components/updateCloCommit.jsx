import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import axios from "axios";
import "./css/teacherCourse.css";

const UpdateCLOCommit = () => {
  const [updateRequestData, setUpdateRequestData] = useState([]);
  const history = useHistory();
  const getTokken = localStorage.getItem("token");

  const getUpdateRequestBulkData = async () => {
    try {
      await axios
        .get("https://20.204.30.1/api/cds/admin/uncommitted_clo_updation/", {
          headers: {
            "X-Access-Token": getTokken,
          },
        })
        .then((response) => {
          setUpdateRequestData(response.data.data);
        });
    } catch (error) {}
  };

  const handleOnClick = (requestData) => {
    history.push({
      pathname: "/update-clo-commits/form",
      state: {
        selectedRequestData: requestData,
      },
    });
  };

  useEffect(() => {
    getUpdateRequestBulkData();
  }, []);

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading">Update CLO Requests</h1>

        {updateRequestData.length === 0 ? (
          <p className="para">No update requests are pending</p>
        ) : (
          updateRequestData.map((requestData) => (
            <button
              type="button"
              className="course-btn"
              onClick={() => handleOnClick(requestData)}
            >
              Update CLO Request by {requestData.obeName}
            </button>
          ))
        )}
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default UpdateCLOCommit;
