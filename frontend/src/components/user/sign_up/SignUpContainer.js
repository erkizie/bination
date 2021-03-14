import React, {Component} from 'react';
import SignUpForm from './SignUpForm.js';
import validateSignUpForm from './lib/validate';
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

    this.pwMask = this.pwMask.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.validateForm = this.validateForm.bind(this);
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

  validateForm(event) {
    event.preventDefault();
    let payload = validateSignUpForm(event, this.state.user);
    if (payload.success) {
      this.setState({
        errors: {},
      });
      let user = {
        usr: this.state.user.username,
        pw: this.state.user.password,
        email: this.state.user.email,
      };
    } else {
      const errors = payload.errors;
      this.setState({
        errors,
      });
    }
  }

  pwMask(event) {
    event.preventDefault();
    this.setState(state =>
        Object.assign({}, state, {
          type: this.state.type === 'password' ? 'text' : 'password',
          btnTxt: this.state.btnTxt === 'show' ? 'hide' : 'show',
        }),
    );
  }

  render() {
    return (
        <div>
          <SignUpForm
              onSubmit={this.validateForm}
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
