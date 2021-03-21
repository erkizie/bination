import validator from 'validator';

const validateSignUpForm = (e, payload) => {
  const errors = {};
  let isFormValid = true;
  
  cleanValidationStyles(e.target);

  if (e.target.name === 'username') {
    if (
        !payload ||
        typeof payload.username !== 'string' ||
        payload.username.trim().length === 0
    ) {
      setInvalidStyle(e.target, 'Please provide a user name.');
    } else {
      setValidStyle(e.target);
    }
  }

  if (e.target.name === 'email') {
    if (
        !payload ||
        typeof payload.email !== 'string' ||
        !validator.isEmail(payload.email)
    ) {
      setInvalidStyle(e.target, 'Please provide a correct email address.');
    } else {
      setValidStyle(e.target);
    }
  }

  if (e.target.name === 'password') {
    if (
        !payload ||
        typeof payload.password !== 'string' ||
        payload.password.trim().length < 8
    ) {
      setInvalidStyle(e.target, 'Password must have at least 8 characters.');
    } else {
      setValidStyle(e.target);
    }
  }

  if (e.target.name === 'pwconfirm') {
    if (!payload || payload.pwconfirm !== payload.password) {
      setInvalidStyle(e.target, 'Password confirmation doesn\'t match.');
    } else {
      setValidStyle(e.target);
    }
  }

  function cleanValidationStyles(input) {
    input.className = input.className.replace(' is-valid', '');
    input.className = input.className.replace(' is-invalid', '');
  }

  function setInvalidStyle(input, errorMsg) {
    input.className += ' is-invalid';
    errors[input.name] = errorMsg;
    isFormValid = false;
  }

  function setValidStyle(input) {
    input.className += ' is-valid';
  }

  return {
    success: isFormValid,
    errors,
  };
};

export default validateSignUpForm;
