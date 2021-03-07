import React, { Component } from "react";
import SignUpForm from "./SignUpForm.js";

class SignUpContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      user: {
        username: "",
        email: "",
        password: ""
      }
    };

  }

  render() {
    return (
        <div>
          <SignUpForm
              user={this.state.user}
          />
        </div>
    );
  }
}

export default SignUpContainer;
