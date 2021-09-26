import React, { useEffect, useState } from "react";
import { useLocation } from "react-router";
import axios from "axios";
import { withStyles, makeStyles } from "@material-ui/core/styles";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Paper from "@material-ui/core/Paper";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import { Button } from "@material-ui/core";
import "./css/gradeButton.css";
import { useHistory } from "react-router";
import { toast } from "react-toastify";

const getTokken = localStorage.getItem("token");

// Defining table width
const useStyles = makeStyles({
  table: {
    minWidth: 650,
  },
});

//Styling the cells of the table
const StyledTableCell = withStyles((theme) => ({
  head: {
    backgroundColor: theme.palette.info.dark,
    color: theme.palette.common.white,
  },
  body: {
    fontSize: 14,
  },
}))(TableCell);

//Styling the rows of the table
const StyledTableRow = withStyles((theme) => ({
  root: {
    "&:nth-of-type(odd)": {
      backgroundColor: theme.palette.action.hover,
    },
  },
}))(TableRow);

const GradeAssessmentTool = () => {
  const location = useLocation();
  const [assessmentToolBulkData, setAssessmentToolBulkData] = useState([]);
  const notConductedAssessmentTools = [];
  const classes = useStyles();
  const history = useHistory();

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

  //Filtering
  for (let i = 0; i < assessmentToolBulkData.length; i++) {
    if (assessmentToolBulkData[i].isConducted === 0) {
      notConductedAssessmentTools.push(assessmentToolBulkData[i]);
    }
  }

  //Header to be send through post request
  let axiosHeader = {
    headers: {
      "X-Access-Token": getTokken,
    },
  };

  const handleGrade = (a, b) => {
    //Date to be send through post request
    const data = {
      toolId: a,
      type: b,
    };

    axios
      .post(
        "https://20.204.30.1/api/assessment_tool_definition/teacher/mark_conducted/",
        data,
        axiosHeader
      )
      .then(
        (response) => {
          console.log(response.data.Message);
        },
        (error) => {
          toast.error(error);
        }
      );

    history.push({
      pathname:
        "/course/course-detail/assessment-tool/grade-assessment-tools/grade",
    });
  };

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">
          {location.state.courseName} ({location.state.courseCode})
        </h2>
        <br />
        <TableContainer component={Paper}>
          <Table className={classes.table} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>Tool Name</StyledTableCell>
                <StyledTableCell align="center">CLO Name</StyledTableCell>
                <StyledTableCell align="center">Section Name</StyledTableCell>
                <StyledTableCell align="center">Total Marks</StyledTableCell>
                <StyledTableCell align="center">Type</StyledTableCell>
                <StyledTableCell align="center">Status</StyledTableCell>
                <StyledTableCell align="center">Grade</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {notConductedAssessmentTools.map((tool) => (
                <StyledTableRow key={tool.toolName}>
                  <StyledTableCell>{tool.toolName}</StyledTableCell>
                  <StyledTableCell align="center">
                    {tool.cloName}
                  </StyledTableCell>
                  <StyledTableCell align="center">
                    {tool.sectionName}
                  </StyledTableCell>
                  <StyledTableCell align="center">
                    {tool.totalMarks}
                  </StyledTableCell>
                  <StyledTableCell align="center">{tool.Type}</StyledTableCell>
                  <StyledTableCell align="center">
                    {tool.isConducted == "0" ? "Not Conducted" : "Conducted"}{" "}
                  </StyledTableCell>
                  <StyledTableCell align="center">
                    <Button
                      className="grade-button"
                      onClick={() => handleGrade(tool.toolId, tool.Type)}
                    >
                      Mark as Conducted
                    </Button>
                  </StyledTableCell>
                </StyledTableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </div>
      <Footer />
    </React.Fragment>
  );
};

export default GradeAssessmentTool;
