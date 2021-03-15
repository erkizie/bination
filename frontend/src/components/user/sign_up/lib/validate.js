import validator from "validator";

const validateSignUpForm = (e, payload) => {
  const errors = {};
  let isFormValid = true;

  if (
      !payload ||
      typeof payload.username !== "string" ||
      payload.username.trim().length === 0
  ) {
    isFormValid = false;
    e.target.elements[0].className += " is-invalid"
    errors.username = "Please provide a user name.";
  } else {
    e.target.elements[0].className = e.target.elements[0].className.replace('is-invalid', '');
    e.target.elements[0].className += " is-valid"
  }

  if (
      !payload ||
      typeof payload.email !== "string" ||
      !validator.isEmail(payload.email)
  ) {
    isFormValid = false;
    e.target.elements[1].className += " is-invalid"
    errors.email = "Please provide a correct email address.";
  } else {
    e.target.elements[1].className = e.target.elements[1].className.replace('is-invalid', '');
    e.target.elements[1].className += " is-valid"
  }


  if (
      !payload ||
      typeof payload.password !== "string" ||
      payload.password.trim().length < 8
  ) {
    isFormValid = false;
    e.target.elements[2].className += " is-invalid"
    errors.password = "Password must have at least 8 characters.";
  } else {
    e.target.elements[2].className = e.target.elements[2].className.replace('is-invalid', '');
    e.target.elements[2].className += " is-valid"
  }

  if (!payload || payload.pwconfirm !== payload.password) {
    isFormValid = false;
    e.target.elements[4].className += " is-invalid"
    errors.pwconfirm = "Password confirmation doesn't match.";
  } else {
    e.target.elements[4].className = e.target.elements[4].className.replace('is-invalid', 'is-valid');
    e.target.elements[4].className += " is-valid"
  }

  return {
    success: isFormValid,
    errors
  };
};


export default validateSignUpForm;
