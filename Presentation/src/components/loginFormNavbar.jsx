import React from "react";
import nedlogonav from "./nedlogonav.png";
import "./css/loginformnavbar.css";

function LoginFormNavbar(props) {
  return (
    <div className="background">
      <div className="container">
        <img className="image-size" src={nedlogonav} alt="" />
        <h3 className="h-height">NED UNIVERSITY OF ENGINEERING & TECHNOLOGY</h3>
        <h4>OBE Portal Login</h4>
      </div>
    </div>
  );
}

export default LoginFormNavbar;
