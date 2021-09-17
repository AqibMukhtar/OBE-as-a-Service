import React from "react";
import { MDBContainer, MDBRow} from 'mdbreact';
import "./css/teacherCourse.css";

const DeleteCLO = () => {

return (
    <MDBContainer>
        <MDBRow className="center">
            <form>
                <h1>Delete CLO</h1>
                <label className="grey-text">
                Course ID
                </label>
                <input type="text" className="form-control" />
                <br />
                <label className="grey-text">
                CLO Name
                </label>
                <input type="text" className="form-control" />
                <div className="text-center mt-4">
                    <button className = "styled-button">
                        Delete CLO
                    </button>
                </div>
            </form>
        </MDBRow>
    </MDBContainer>
      );
    }

export default DeleteCLO;