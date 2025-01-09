class UserInputValidator {
  static (bool, String) validUserName(String? username) {
    if (username != null && username.isNotEmpty) {
      RegExp regExp =
          RegExp(r"^(?!\.)(?!.*\.$)(?!.*?\.\.)[a-zA-Z][a-zA-Z0-9._]+$");
      if (username.length < 5) {
        return (false, "Username is too short!");
      }
      if (username.length > 30) {
        return (false, "Username is too big!");
      }
      if (!regExp.hasMatch(username.trim())) {
        return (false, "Please add proper username");
      }
      regExp = RegExp(r"\s");
      if (regExp.hasMatch(username.trim())) {
        return (false, "Username should not contain spaces");
      }
    } else {
      return (false, "Please enter username");
    }
    return (true, "");
  }

  static (bool, String) validPassword(String? password) {
    if (password != null && password.isNotEmpty) {
      if (password.length < 8) {
        return (false, "Password is too short!");
      }
      if (password.length > 40) {
        return (false, "Password is too big!");
      }
      var regExp = RegExp(r"\s");
      if (regExp.hasMatch(password.trim())) {
        return (false, "Password should not contain spaces");
      }
    } else {
      return (false, "Please enter password");
    }
    return (true, "");
  }

  static (bool, String) validEmail(String? email) {
    if (email != null && email.isNotEmpty) {
      RegExp regExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (email.length < 5) {
        return (false, "Username is too short!");
      }
      if (email.length > 300) {
        return (false, "Username is too big!");
      }
      if (!regExp.hasMatch(email.trim())) {
        return (false, "Please enter valid email");
      }
      regExp = RegExp(r"\s");
      if (regExp.hasMatch(email.trim())) {
        return (false, "email should not contain spaces");
      }
    } else {
      return (false, "Please enter email id");
    }
    return (true, "");
  }

  static (bool, String) strongPassword(String? password) {
    if (password != null && password.isNotEmpty) {
      RegExp regExp =
          RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[&@#]).{8,}$");

      if (password.length < 5) {
        return (false, "Password is too short!");
      }
      if (password.length > 150) {
        return (false, "Password is too big!");
      }
      if (!regExp.hasMatch(password.trim())) {
        return (false, "Please enter strong password");
      }
      regExp = RegExp(r"\s");
      if (regExp.hasMatch(password.trim())) {
        return (false, "password should not contain spaces");
      }
    } else {
      return (false, "Please enter password ");
    }
    return (true, "");
  }
}
