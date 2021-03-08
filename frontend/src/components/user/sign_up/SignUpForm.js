import React from 'react';
import './style.css';
import TextField from '@material-ui/core/TextField';

const SignUpForm = ({user}) => {
  return (
      <div className="loginBox">
        <h1>Sign Up</h1>
        <form>
          <div className="inputElement">
            <TextField
                name="username"
                label="user name"
                value={user.username}
            />
          </div>
          <div className="inputElement">
            <TextField
                className="inputField"
                name="email"
                label="email"
                value={user.email}
            />
          </div>
          <div className="inputElement">
            <TextField
                name="password"
                label="password"
                value={user.password}
            />
          </div>
          <div className="inputElement">
            <button type="button" className="btn btn-info btn-sm">
              Register
            </button>
          </div>
        </form>
        <div>
          <p>
            Already have an account? <br/>
            <a href="/">Log in here</a>
          </p>
        </div>
      </div>
  );
};

export default SignUpForm;
