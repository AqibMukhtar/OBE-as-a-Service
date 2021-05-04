import React from "react";
import Select from "react-select";
import Joi from "joi-browser";
import Form from "./form";
import Input from "./input";
import { login } from "../services/authService";
import LoginFormNavbar from "./loginFormNavbar";
import "./css/loginform.css";
// import "./css/loginformnavbar.css";

const options = [
  { value: "teacher", label: "Teacher" },
  { value: "admin", label: "Admin" },
  { value: "student", label: "Student" },
  { value: "obecell", label: "OBE Cell" },
];
class LoginForm extends Form {
  state = {
    selectedOption: null,
    data: { username: "", password: "", selectedOption: null },
    errors: {},
  };

  schema = {
    username: Joi.string().required().label("Username"),
    password: Joi.string().required().label("Password"),
    selectedOption: Joi.required(),
  };

  doSubmit = async () => {
    try {
      const { data, selectedOption } = this.state;
      const { data: jwt } = await login(
        data.username,
        data.password,
        selectedOption.value
      );
      localStorage.setItem("token", jwt);
      this.props.history.push("/login");
    } catch (ex) {
      if (ex.response && ex.response.status === 400) {
        const errors = { ...this.state.errors };
        errors.username = ex.response.data;
        this.setState({ errors });
      }
    }
  };

  handleOnChange = (selectedOption) => {
    this.setState({ selectedOption });
    console.log(`Option selected:`, selectedOption.value);
  };
  render() {
    const { data, errors, selectedOption } = this.state;
    return (
      <>
        <div className="login_form_background">
          <LoginFormNavbar />
          <div className="center">
            <h1>Login</h1>
            <form onSubmit={this.handleSubmit}>
              <div className="txt_field">
                <Input
                  name="username"
                  value={data.username}
                  label="Username"
                  placeholder="Enter Username"
                  type="text"
                  onChange={this.handleChange}
                  error={errors.username}
                />
                <Input
                  name="password"
                  value={data.password}
                  label="Password"
                  placeholder="Enter Password"
                  type="password"
                  onChange={this.handleChange}
                  error={errors.password}
                />
                <br></br>
                <Select
                  className="change-font"
                  value={selectedOption}
                  onChange={this.handleOnChange}
                  options={options}
                  placeholder="Login As"
                />
              </div>
              <button disabled={this.validate()} className="custome_button">
                Login
              </button>
              <div className="pass">Forgot Password?</div>
            </form>
          </div>
        </div>
      </>
    );
  }
}

export default LoginForm;
