import React, {Component} from 'react';
import SignUpForm from './SignUpForm.js';
import zxcvbn from 'zxcvbn';

class SignUpContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      errors: {},
      user: {
        username: '',
        email: '',
        password: '',
        pwconfirm: '',
      },
      btnTxt: 'show',
      type: 'password',
      score: '0',
    };

    this.handleChange = this.handleChange.bind(this);
    this.pwHandleChange = this.pwHandleChange.bind(this);
  }

  handleChange(event) {
    const field = event.target.name;
    const user = this.state.user;
    user[field] = event.target.value;

    this.setState({
      user,
    });
  }

  pwHandleChange(event) {
    const field = event.target.name;
    const user = this.state.user;
    user[field] = event.target.value;

    this.setState({
      user,
    });

    if (event.target.value === '') {
      this.setState(state =>
          Object.assign({}, state, {
            score: 'null',
          }),
      );
    } else {
      let pw = zxcvbn(event.target.value);
      this.setState(state =>
          Object.assign({}, state, {
            score: pw.score + 1,
          }),
      );
    }
  }


  render() {
    return (
        <div>
          <SignUpForm
              onChange={this.handleChange}
              onPwChange={this.pwHandleChange}
              errors={this.state.errors}
              user={this.state.user}
              score={this.state.score}
              btnTxt={this.state.btnTxt}
              type={this.state.type}
              pwMask={this.pwMask}
          />
        </div>
    );
  }
}

export default SignUpContainer;
