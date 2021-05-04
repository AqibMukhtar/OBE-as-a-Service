import React, { Component } from 'react';
import './Footer.css'
import {Facebook} from 'react-feather';
import {Home} from 'react-feather';
import {Mail} from 'react-feather';
import {Phone} from 'react-feather';

class Footer extends Component {
    state = {  }
    render() { 
        return (
            <React.Fragment>
                <div className="footer1">
                    <div className="container">
                         <div className="container-child">
                            <h3>Contact Developers</h3>
                            <ul>
                                <li>MuhammadUzair@gmail.com</li>
                                <li>AqibMukhtar@gmail.com</li>
                                <li>AbdulRehman@gmail.com</li>
                            </ul>
                        </div>
                    </div>
                    <div className="container">
                         <p> </p>
                    </div>
                    <div className="container">
                        <div className="container-child">
                            <h3>About us</h3>
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
                            <div className="icon-side">
                                <p> </p>
                            </div>
                            <div className="icon-side">
                                <div className="icons">
                                    <div className="container-icon">
                                        <Facebook/>
                                    </div>
                                </div>
                                <div className="icons">
                                    <div className="container-icon">
                                        <Mail/>
                                    </div>
                                </div>
                                <div className="icons">
                                    <div className="container-icon">
                                        <Phone/>
                                    </div>
                                </div>
                                <div className="icons">
                                    <div className="container-icon">
                                        <Home/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </React.Fragment>
          );
    }
}
 
export default Footer;