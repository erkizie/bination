import React from 'react';
import './style.css';
import PasswordStr from './PasswordStr';
import {Link as ReactLink} from 'react-router-dom';
import {MDBContainer, MDBRow, MDBCol, MDBBtn, MDBInput} from 'mdbreact';

const SignUpForm = ({
                      onSubmit,
                      onChange,
                      errors,
                      user,
                      score,
                      btnTxt,
                      type,
                      pwMask,
                      onPwChange,
                    }) => {
  return (
      <MDBContainer>
        <MDBRow className="d-flex justify-content-center">
          <MDBCol md="4">
            <form onSubmit={onSubmit}>
              <p className="h5 text-center mb-4">Sign up</p>
              <div className="grey-text">
                <MDBInput name="username"
                          className="inputElement"
                          label="Your username"
                          icon="user"
                          type="text"
                          value={user.username}
                          onChange={onChange}>
                  <div className="invalid-feedback">
                    {errors.username}
                  </div>
                  <div className="valid-feedback">Looks good!</div>
                </MDBInput>
                <MDBInput name="email"
                          className="inputElement"
                          label="Your email"
                          icon="envelope"
                          type="email"
                          value={user.email}
                          onChange={onChange}>
                  <div className="invalid-feedback">
                    {errors.email}
                  </div>
                  <div className="valid-feedback">Looks good!</div>
                </MDBInput>
                <MDBInput type={type}
                          name="password"
                          className="inputElement"
                          label="Your password"
                          icon="lock"
                          value={user.password}
                          onChange={onPwChange}>
                  <div className="invalid-feedback">
                    {errors.password}
                  </div>
                  <div className="valid-feedback">Looks good!</div>
                </MDBInput>

                <div className="pwStrRow">
                  {score >= 1 && (
                      <div>
                        <PasswordStr score={score}/>
                        <MDBBtn
                            className="btn btn-sm"
                            onClick={pwMask}
                            style={{
                              position: 'relative',
                              left: '50%',
                              transform: 'translateX(-50%)',
                            }}
                        >{btnTxt}</MDBBtn>
                      </div>
                  )}
                </div>
                <MDBInput type={type}
                          name="pwconfirm"
                          className="inputElement"
                          label="Confirm password"
                          icon="exclamation-triangle"
                          value={user.pwconfirm}
                          onChange={onChange}>
                  <div className="invalid-feedback">
                    {errors.pwconfirm}
                  </div>
                  <div className="valid-feedback">Looks good!</div>
                </MDBInput>

              </div>
              <div className="text-center">
                <MDBBtn color="primary" type="submit">Register</MDBBtn>
              </div>
            </form>
            <p className="loginBox">
              Aleady have an account? <br/>
              <ReactLink to="/sign_in">Log in here</ReactLink>
            </p>
          </MDBCol>
        </MDBRow>
      </MDBContainer>
  );
};

export default SignUpForm;
