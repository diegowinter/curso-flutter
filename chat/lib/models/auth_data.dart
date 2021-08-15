enum AuthMode {
  LOGIN,
  SIGNUP,
}

class AuthData {
  late String name;
  late String email;
  late String password;
  AuthMode _mode = AuthMode.LOGIN;

  bool get isSignup {
    return _mode == AuthMode.SIGNUP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
  }
}
