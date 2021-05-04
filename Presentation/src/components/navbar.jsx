import React from "react";
import logo from "./ned.PNG";
import { Link } from "react-router-dom";
import Footer from "./footer";
import "./css/navbar.css";

const Navbar = (props) => {
  return (
    <div>
      <div className="topDiv">
        <div className="setMargin">
          <span className="spanMargin">
            <Link to="/login">
              <i className="fa fa-facebook" aria-hidden="true" />
            </Link>
            <Link>
              <i className="fa fa-map-marker" aria-hidden="true"></i>
            </Link>
            <Link>
              <i className="fa fa-book" aria-hidden="true"></i>
            </Link>
            <Link>
              <i className="fa fa-envelope-o" aria-hidden="true"></i>
            </Link>
            <Link>
              <i className="fa fa-phone" aria-hidden="true"></i>
            </Link>
            <Link>
              <i className="fa fa-home" aria-hidden="true"></i>
            </Link>
          </span>
        </div>
      </div>

      <nav className="navbar navbar-expand-sm navbar-light">
        <div className="container-fluid">
          <a
            className="navbar-brand"
            href="https://www.neduet.edu.pk/"
            target="_blank"
          >
            <img className="setImage" src={logo} />
          </a>
          <button
            className="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarSupportedContent">
            <ul className="navbar-nav me-auto mb-2 mb-lg-0">
              <li className="nav-item">
                <Link className="nav-link" to="/login">
                  Course
                </Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to="/login">
                  PEOs
                </Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to="/login">
                  PLOs
                </Link>
              </li>
            </ul>
            <form className="d-flex">
              <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                <Link className="nav-link" to="/login">
                  Logout
                </Link>
              </ul>
            </form>
          </div>
        </div>
      </nav>
      <div className="container mt-4">
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
      </div>
      <br></br>
      <div className="container">
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
      </div>
      <br></br>
      <div className="container">
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Maiores amet,
        doloremque accusamus ratione deleniti eos nobis commodi inventore
        suscipit adipisci dignissimos hic modi pariatur voluptatem obcaecati
        earum repellendus sint et!<br></br>
      </div>
      <Footer />
    </div>
  );
};

export default Navbar;
