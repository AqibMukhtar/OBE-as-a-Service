import React, { Component } from "react";
import "./css/footer.css";

class Footer extends Component {
  state = {};
  render() {
    return (
      <React.Fragment>
        <div className="footer1">
          <div className="container">
            <div className="container-child">
              <h4>Contact Developers</h4>
              <ul>
                <li>muhammaduzair@gmail.com</li>
                <li>aqibmukhtar@gmail.com</li>
                <li>abdulrehman@gmail.com</li>
              </ul>
            </div>
          </div>
          <div className="footer-container">
            <p> </p>
          </div>
          <div className="footer-container">
            <div className="container-child">
              <h4>About us</h4>
              <p>Copyright NED University of Engineering and Technology</p>
            </div>
          </div>
        </div>
        <div className="below">
          <div className="below-side">
            <div className="container-content">
              <p>Powered By DCP</p>
            </div>
          </div>
          <div className="below-side">
            <span>
              <a
                href="https://web.facebook.com/NEDUETOfficial/?_rdc=1&_rdr"
                target="_blank"
              >
                <i className="fa fa-facebook i-element" aria-hidden="true" />
              </a>
              <a href="https://www.neduet.edu.pk/contact-us" target="_blank">
                <i
                  className="fa fa-map-marker i-element"
                  aria-hidden="true"
                ></i>
              </a>
              <a
                href="https://www.neduet.edu.pk/institutional_policies"
                target="_blank"
              >
                <i className="fa fa-book i-element" aria-hidden="true"></i>
              </a>
              <a href="https://mail2.neduet.edu.pk/" target="_blank">
                <i
                  className="fa fa-envelope-o i-element"
                  aria-hidden="true"
                ></i>
              </a>
              <a href="https://www.neduet.edu.pk/contact-us" target="_blank">
                <i className="fa fa-phone i-element" aria-hidden="true"></i>
              </a>
              <a href="https://www.neduet.edu.pk/" target="_blank">
                <i className="fa fa-home i-element" aria-hidden="true"></i>
              </a>
            </span>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

export default Footer;
