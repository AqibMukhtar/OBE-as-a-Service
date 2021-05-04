import React from "react";
import { Switch, Route } from "react-router-dom";
import LoginForm from "./components/loginForm";
import Logout from "./components/logout";
import Navbar from "./components/navbar";
import "./App.css";
function App() {
  return (
    <React.Fragment>
      <div className="content">
        <Switch>
          <Route path="/login" exact component={LoginForm} />
          <Route path="/logout" exact component={Logout} />
          <Route path="/navbar" component={Navbar} />
        </Switch>
      </div>
    </React.Fragment>
  );
}

export default App;
