import React, { useState } from "react";
import { useEffect } from "react";
import { useLocation } from "react-router";
import CloTable from "./cloTable";
import axios from "axios";
import { toast } from "react-toastify";

const CourseClo = () => {
  const location = useLocation();
  const [cloBulkData, setCloBulkData] = useState([]);
  const getTokken = localStorage.getItem("token");

  const getCloData = async () => {
    try {
      await axios
        .get(
          "https://20.204.30.1/api/cds/view_course_clos?programId=" +
            location.state.programId +
            "&courseId=" +
            location.state.courseId,
          {
            headers: {
              "X-Access-Token": getTokken,
            },
          }
        )
        .then((response) => {
          setCloBulkData(response.data.data);
        });
    } catch (ex) {
      toast.error(ex);
    }
  };

  useEffect(() => {
    getCloData();
  }, []);

  return (
    <CloTable
      data={cloBulkData}
      courseName={location.state.courseName}
      courseCode={location.state.courseCode}
    />
  );
};

export default CourseClo;
