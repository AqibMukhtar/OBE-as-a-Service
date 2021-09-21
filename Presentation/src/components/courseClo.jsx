import React, { useState } from "react";
import { useEffect } from "react";
import { useLocation } from "react-router";
import CloTable from "./cloTable";
import axios from "axios";

const getTokken = localStorage.getItem("token");

const CourseClo = () => {
  const location = useLocation();
  const [cloBulkData, setCloBulkData] = useState([]);
  const getCloData = async () => {
    try {
      const CloBulkData = await axios.get(
        "https://20.204.30.1/api/cds/view_course_clos?programId=" +
          location.state.programId +
          "&courseId=" +
          location.state.courseId,
        {
          headers: {
            "X-Access-Token": getTokken,
          },
        }
      );
      setCloBulkData(CloBulkData.data.data);
    } catch (error) {}
  };

  useEffect(() => {
    getCloData();
  });

  console.log(cloBulkData);
  return (
    <CloTable
      data={cloBulkData}
      courseName={location.state.courseName}
      courseCode={location.state.courseCode}
    />
  );
};

export default CourseClo;
