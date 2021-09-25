import React, { useEffect, useState } from "react";
import { useLocation } from "react-router";
import axios from "axios";
import ViewAssessmentToolTable from "./viewAssessmentToolTable";

const getTokken = localStorage.getItem("token");

const ViewAssessmentTool = () => {
  const location = useLocation();
  const [assessmentToolBulkData, setAssessmentToolBulkData] = useState([]);

  const getAssessmentToolData = async () => {
    try {
      const AssessmentToolBulkData = await axios.get(
        "https://20.204.30.1/api/cds/teacher/view_assessment_tools/?courseId=" +
          location.state.courseId +
          "&batchId=" +
          location.state.batchId +
          "&programId=" +
          location.state.programId,
        {
          headers: {
            "X-Access-Token": getTokken,
          },
        }
      );
      setAssessmentToolBulkData(AssessmentToolBulkData.data.data);
      console.log(assessmentToolBulkData);
    } catch (error) {}
  };

  useEffect(() => {
    getAssessmentToolData();
  }, []);

  return (
    <div>
      <ViewAssessmentToolTable
        data={assessmentToolBulkData}
        courseName={location.state.courseName}
        courseCode={location.state.courseCode}
      />
    </div>
  );
};

export default ViewAssessmentTool;
