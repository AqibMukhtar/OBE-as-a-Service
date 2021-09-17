import React from "react";
import { MDBContainer, MDBRow} from 'mdbreact';
import "./css/teacherCourse.css";

const UpdateCLO = () => {

return (
    <MDBContainer>
        <MDBRow className="center">
            <form>
                <h1>Update CLO</h1>
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
                        Update CLO
                    </button>
                </div>
            </form>
        </MDBRow>
    </MDBContainer>
      );
    }

export default UpdateCLO;