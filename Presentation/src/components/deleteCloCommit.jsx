import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import axios from "axios";
import "./css/teacherCourse.css";

const DeleteCLOCommit = () => {
  const [deleteRequestData, setDeleteRequestData] = useState([]);
  const history = useHistory();
  const getTokken = localStorage.getItem("token");

  const getDeleteRequestBulkData = async () => {
    try {
      await axios
        .get("https://20.204.30.1/api/cds/admin/uncommitted_clo_deletion/", {
          headers: {
            "X-Access-Token": getTokken,
          },
        })
        .then((response) => {
          setDeleteRequestData(response.data.data);
        });
    } catch (error) {}
  };

  const handleOnClick = (requestData) => {
    history.push({
      pathname: "/delete-clo-commits/form",
      state: {
        selectedRequestData: requestData,
      },
    });
  };

  useEffect(() => {
    getDeleteRequestBulkData();
  }, []);

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading">Delete CLO Requests</h1>

        {deleteRequestData.length === 0 ? (
          <p className="para">No delete requests are pending</p>
        ) : (
          deleteRequestData.map((requestData) => (
            <button
              type="button"
              className="course-btn"
              onClick={() => handleOnClick(requestData)}
            >
              Delete CLO Request by {requestData.obeName}
            </button>
          ))
        )}
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default DeleteCLOCommit;
