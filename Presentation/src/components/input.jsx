import React from "react";
const Input = ({ name, label, value, error, type, placeholder, onChange }) => {
  return (
    <div className="form-group">
      <label className="login_label" htmlFor={name}>
        {label}
      </label>
      <input
        value={value}
        onChange={onChange}
        id={name}
        name={name}
        type={type}
        placeholder={placeholder}
        className="txt_field_input"
      />
      {error && <div className="alert alert-danger">{error}</div>}
    </div>
  );
};

export default Input;
