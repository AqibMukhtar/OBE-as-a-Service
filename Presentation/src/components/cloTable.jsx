import React from 'react';
import { withStyles, makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

const useStyles = makeStyles({
    table: {
      minWidth: 650,
    },
  });

  const StyledTableCell = withStyles((theme) => ({
    head: {
      backgroundColor: theme.palette.info.dark,
      color: theme.palette.common.white,
    },
    body: {
      fontSize: 14,
    },
  }))(TableCell);
  
  const StyledTableRow = withStyles((theme) => ({
    root: {
      '&:nth-of-type(odd)': {
        backgroundColor: theme.palette.action.hover,
      },
    },
  }))(TableRow);

const CloTable = (props) => {

    const classes = useStyles();

    return (
        <React.Fragment>
            <TableContainer component={Paper}>
                <Table className={classes.table} aria-label="customized table">
                    <TableHead>
                        <TableRow>
                            <StyledTableCell>CLO Name</StyledTableCell>
                            <StyledTableCell align="center">CLO Description</StyledTableCell>
                            <StyledTableCell align="center">PLO ID</StyledTableCell>
                            <StyledTableCell align="center">PLO Name</StyledTableCell>
                            <StyledTableCell align="center">PLO Description</StyledTableCell>
                            <StyledTableCell align="center">Taxonomy Level Name</StyledTableCell>
                            <StyledTableCell align="center">Taxonomy ID</StyledTableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        { props.data.map((d) => (
                            <StyledTableRow key={d.cloName}>
                                <StyledTableCell>{d.cloName}</StyledTableCell>
                                <StyledTableCell align="center">{d.cloDescription}</StyledTableCell>
                                <StyledTableCell align="center">{d.ploId}</StyledTableCell>
                                <StyledTableCell align="center">{d.ploName}</StyledTableCell>
                                <StyledTableCell align="center">{d.ploDescription}</StyledTableCell>
                                <StyledTableCell align="center">{d.taxonomyLevelName}</StyledTableCell>
                                <StyledTableCell align="center">{d.taxonomyLevelShortHand}</StyledTableCell>
                            </StyledTableRow>
                        ))}
                    </TableBody> 
                </Table>
            </TableContainer>
        </React.Fragment>
    );
}
 
export default CloTable;