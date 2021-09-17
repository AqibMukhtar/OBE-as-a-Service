import React from "react";
import { MDBContainer, MDBRow} from 'mdbreact';
import "./css/teacherCourse.css";

const AddCLO = () => {

return (
    <MDBContainer>
        <MDBRow className="center-container">
            <form>
                <h1 className="h2 text-center mb-2">Add CLO</h1>
                <label className="grey-text">
                Course ID
                </label>
                <input type="text" className="form-control" />
                <br />
                <label className="grey-text">
                CLO Name
                </label>
                <input type="text" className="form-control" />
                <br />
                <label className="grey-text">
                CLO Description
                </label>
                <input type="text" className="form-control" />
                <br />
                <label className="grey-text">
                Mapping to PLO
                </label>
                <input type="text" className="form-control" rows="3" />
                <div className="text-center mt-4">
                    <button className = "styled-button">
                        Add CLO
                    </button>
                </div>
            </form>
        </MDBRow>
    </MDBContainer>
      );
    }

export default AddCLO;