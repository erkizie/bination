import React from "react";
import "./style.css";
import Button from '@material-ui/core/Button'

const SignUpForm = ({user}) => {
  return (
      <div className="loginBox">
        <h1>Sign Up</h1>

        <form>
          <input
              name="username"
              floatingLabelText="user name"
              value={user.username}>
          </input>
          <input
              name="email"
              floatingLabelText="email"
              value={user.email}>
          </input>
          <input
              name="password"
              floatingLabelText="password"
              value={user.password}>
          </input>
          <br />
          <Button
              className="signUpSubmit"
              primary={true}
              type="submit"
              label="submit"
          />
        </form>
        <p>
          Already have an account? <br />
          <a href="/">Log in here</a>
        </p>
      </div>
  );
};

export default SignUpForm;
