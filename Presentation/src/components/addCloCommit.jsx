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

const AddCLOCommit = () => {
  const classes = useStyles();
  const data = [];

  const getCloRequestData = () => {};

  useEffect(() => {
    getCloRequestData();
  });

  return (
    <React.Fragment>
      <RealNavbar />
      <div className="container mt-4">
        <h2 className="heading">Add CLO Requests</h2>
        <br />
        <TableContainer component={Paper}>
          <Table className={classes.table} aria-label="customized table">
            <TableHead>
              <TableRow>
                <StyledTableCell>Request</StyledTableCell>
                <StyledTableCell align="center">Commit</StyledTableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {data.map((row) => (
                <StyledTableRow key={row.id}>
                  <StyledTableCell>{row.requestName}</StyledTableCell>
                  <StyledTableCell align="center">
                    <Button className="grade-button">commit</Button>
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

export default AddCLOCommit;
