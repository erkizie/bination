import React from 'react';
import './style.css';
import TextField from '@material-ui/core/TextField';
import { MDBContainer, MDBRow, MDBCol, MDBBtn, MDBInput } from 'mdbreact';


const SignUpForm = ({user}) => {
  return (
      <MDBContainer>
        <MDBRow className="d-flex justify-content-center">
          <MDBCol md="4">
            <form>
              <p className="h5 text-center mb-4">Sign up</p>
              <div className="grey-text">
                <MDBInput label="Your username" icon="user" group type="text" validate error="wrong"
                          success="right" />
                <MDBInput label="Your email" icon="envelope" group type="email" validate error="wrong"
                          success="right" />
                <MDBInput label="Your password" icon="lock" group type="password" validate />
              </div>
              <div className="text-center">
                <MDBBtn color="primary">Register</MDBBtn>
              </div>
            </form>
          </MDBCol>
        </MDBRow>
      </MDBContainer>
  );
};

export default SignUpForm;
