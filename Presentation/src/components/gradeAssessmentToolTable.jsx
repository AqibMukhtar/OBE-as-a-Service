import React from "react";
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

const GradeAssessmentToolTable = (props) => {
  const classes = useStyles();
  const history = useHistory();

  const handleGrade = () => {
    history.push({
      pathname:
        "/course/course-detail/assessment-tool/grade-assessment-tool/graded",
      state: {
        courseName: props.courseName,
        courseCode: props.courseCode,
        data: props.data,
        assessmentToolBulkData: props.data2,
      },
    });
  };
  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">
          {props.courseName} ({props.courseCode})
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
              {props.data.map((tool) => (
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
                    <Button className="grade-button" onClick={handleGrade}>
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

export default GradeAssessmentToolTable;
