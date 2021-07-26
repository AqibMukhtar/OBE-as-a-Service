import React, { Component } from 'react';
import axios from "axios";
import CloTable from './cloTable';

const getTokken = localStorage.getItem("token");

class CourseClo extends Component {

  getData = () => {
    axios
      .get("https://20.204.30.1/api/cds/view_course_clos?programId="+ this.props.selectedCourse.programId +"&courseId="+ this.props.selectedCourse.courseId, {
        headers: {
          "X-Access-Token": getTokken
        },
      })
      .then((response) => {
        const data = response.data.data;
        this.setState({ allData: data });
        console.log(this.state.allData);
      })
      .catch((error) => {
        console.log(error);
        console.log(error.response.status);
        const expectedError =
        error.response.status >= 300 ||
        error.response.status < 200;
        this.setState({expectedError});
      if (expectedError) {
        alert("An error occurred");
        window.location="/logout";
      }
      return Promise.reject(error);
      })
  }

  componentDidMount() {
    this.getData();
  }

  state = { 
    allData: []
   }
  render() { 
    return (
      <CloTable
        data = {this.state.allData}
      />
     );
  }
}
 
export default CourseClo;
