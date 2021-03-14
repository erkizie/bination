import React, {Component} from 'react';
import SignUpForm from './SignUpForm.js';

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
  }

  handleChange(event) {
    const field = event.target.name;
    const user = this.state.user;
    user[field] = event.target.value;

    this.setState({
      user,
    });
  }


  render() {
    return (
        <div>
          <SignUpForm
              onChange={this.handleChange}
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
