import React from "react";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/peoStyle.css";

const PEODescription = () => {
  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading-PEO">Program Educational Objectives (PEOs):</h1>
        <p className="plo-paragraph">
          The following are the PEOs of department of Software Engineering
        </p>
        <h2 className="heading-sub"> PEO-1:</h2>
        <p className="plo-paragraph">
          Exhibit comprehensive knowledge and agility to address problems in the
          Computer Science & Information Technology sphere of influence as
          capable engineers and academics
        </p>
        <h2 className="heading-sub"> PEO-2:</h2>
        <p className="plo-paragraph">
          Work and communicate with understanding as individuals and in
          multidisciplinary terms.
        </p>
        <h2 className="heading-sub">PEO-3:</h2>
        <p className="plo-paragraph">
          Undertake professional practice considering ethical and societal
          implications.
        </p>
        <h2 className="heading-sub">PEO-4:</h2>
        <p className="plo-paragraph">
          Versatility to adapt to the progressive dynamics of the computer
          science, Information Technology and computing domain through continued
          professional development and life-long learning.
        </p>
      </div>
      <Footer />
    </>
  );
};

export default PEODescription;
