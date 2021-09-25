import React from "react";
import RealNavbar from "./realNavbar";
import Footer from "./footer";
import "./css/peoStyle.css";

const PLODescription = () => {
  return (
    <>
      <RealNavbar />
      <div className="container mt-4">
        <h1 className="heading-PEO">Program Learning Objectives ( PLOs ):</h1>

        <h2 className="heading-sub">1. Engineering Knowledge:</h2>
        <p className="plo-paragraph">
          An ability to apply knowledge of mathematics, science, engineering
          fundamentals and an engineering specialization to the solution of
          complex engineering problems.
        </p>

        <h2 className="heading-sub">2. Problem Analysis:</h2>
        <p className="plo-paragraph">
          An ability to identify, formulate, research literature, and analyze
          complex engineering problems reaching substantiated conclusions using
          first principles of mathematics, natural sciences and engineering
          sciences.
        </p>

        <h2 className="heading-sub">3. Design/Development of Solutions:</h2>
        <p className="plo-paragraph">
          An ability to design solutions for complex engineering problems and
          design systems, components or processes that meet specified needs with
          appropriate consideration for public health and safety, cultural,
          societal, and environmental considerations.
        </p>

        <h2 className="heading-sub">4. Investigation:</h2>
        <p className="plo-paragraph">
          An ability to investigate complex engineering problems in a methodical
          way including literature survey, design and conduct of experiments,
          analysis and interpretation of experimental data, and synthesis of
          information to derive valid conclusions
        </p>

        <h2 className="heading-sub">5. Modern Tool Usage:</h2>
        <p className="plo-paragraph">
          An ability to create, select and apply appropriate techniques,
          resources, and modern engineering and IT tools, including prediction
          and modeling, to complex engineering activities, with an understanding
          of the limitations
        </p>

        <h2 className="heading-sub">6. The Engineer and Society:</h2>
        <p className="plo-paragraph">
          An ability to apply reasoning informed by contextual knowledge to
          assess societal, health, safety, legal and cultural issues and the
          responsibilities relevant to professional engineering practice and
          solution to complex engineering problems.
        </p>

        <h2 className="heading-sub">7. Environment and Stability:</h2>
        <p className="plo-paragraph">
          An ability to understand the impact of professional engineering
          solutions in societal and environmental contexts and demonstrate
          knowledge of and need for sustainable development.
        </p>

        <h2 className="heading-sub">8. Ethics:</h2>
        <p className="plo-paragraph">
          Apply ethical principles and commit to professional ethics and
          responsibilities and norms of engineering practice.
        </p>

        <h2 className="heading-sub">9. Individual and Team Work:</h2>
        <p className="plo-paragraph">
          An ability to work effectively, as an individual or in a team, on
          multifaceted and/or multidisciplinary settings.
        </p>

        <h2 className="heading-sub">10. Communication:</h2>
        <p className="plo-paragraph">
          An ability to communicate effectively, orally as well as in writing,
          on complex engineering activities with the engineering community and
          with society at large, such as being able to comprehend and write
          effective reports and design documentation, make effective
          presentations, and give and receive clear instructions.
        </p>

        <h2 className="heading-sub">11. Project Management:</h2>
        <p className="plo-paragraph">
          An ability to demonstrate management skills and apply engineering
          principles to one‟s own work, as a member and/or leader in a team, to
          manage projects in a multidisciplinary environment
        </p>

        <h2 className="heading-sub">12. Lifelong Learning:</h2>
        <p className="plo-paragraph">
          An ability to recognize importance of, and pursue lifelong learning in
          the broader context of innovation and technological developments.
        </p>
      </div>
      <Footer />
    </>
  );
};

export default PLODescription;
