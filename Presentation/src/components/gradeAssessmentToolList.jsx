// import React, { useEffect, useState } from "react";
// import { useLocation } from "react-router";
// import axios from "axios";
// import GradeAssessmentToolTable from "./gradeAssessmentToolTable";

// const getTokken = localStorage.getItem("token");

// const GradeAssessmentTool = () => {
//   const location = useLocation();
//   const [assessmentToolBulkData, setAssessmentToolBulkData] = useState([]);
//   const notConductedAssessmentTools = [];

//   const getAssessmentToolData = async () => {
//     try {
//       const AssessmentToolBulkData = await axios.get(
//         "https://20.204.30.1/api/cds/teacher/view_assessment_tools/?courseId=" +
//           location.state.courseId +
//           "&batchId=" +
//           location.state.batchId +
//           "&programId=" +
//           location.state.programId,
//         {
//           headers: {
//             "X-Access-Token": getTokken,
//           },
//         }
//       );
//       setAssessmentToolBulkData(AssessmentToolBulkData.data.data);
//       console.log(assessmentToolBulkData);
//     } catch (error) {}
//   };

//   useEffect(() => {
//     getAssessmentToolData();
//   });

//   for (let i = 0; i < assessmentToolBulkData.length; i++) {
//     if (assessmentToolBulkData[i].isConducted === 0) {
//       notConductedAssessmentTools.push(assessmentToolBulkData[i]);
//     }
//   }

//   console.log(notConductedAssessmentTools);

//   return (
//     <div>
//       <GradeAssessmentToolTable
//         data={notConductedAssessmentTools}
//         courseName={location.state.courseName}
//         courseCode={location.state.courseCode}
//         data2={assessmentToolBulkData}
//       />
//     </div>
//   );
// };

// export default GradeAssessmentTool;
