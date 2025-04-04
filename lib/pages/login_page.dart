import 'package:finstagram/widgets/app_bar_widget.dart';
import 'package:finstagram/widgets/mao_button.dart';
import 'package:finstagram/widgets/mao_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context, _deviceHeight * 0.15),
      body: _home(),
    );
  }

  Widget _home() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _loginFormKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              _emailField(),
              _passwordField(),
              _loginButton(),
              _linkToRegisterPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaoButton(
      onClick: () {
        String message;
        if (_loginFormKey.currentState != null &&
            _loginFormKey.currentState!.validate()) {
          _loginFormKey.currentState!
              .save(); // Call every onSave() methods in FormField
          message = "Login success: Email is $email and Password is $password";
        } else {
          message = "Login failed";
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      },
      text: "Login",
      width: _deviceWidth,
    );
  }

  Widget _emailField() {
    return MaoTextFormField(
      title: "Enter your email",
      validator: (val) {
        if (val != null) {
          return val.contains("@") ? null : "Email must be followed by @ sign";
        }
        return "Email must not be empty!";
      },
      onSave: (val) {
        email = val;
      },
    );
  }

  Widget _passwordField() {
    return MaoTextFormField(
      title: "Enter your password",
      obscureText: true,
      validator: (val) {
        return val!.length > 4
            ? null
            : "Password must be at least 5 characters";
      },
      onSave: (val) {
        password = val;
      },
    );
  }

  Widget _linkToRegisterPage() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "register");
      },
      child: Text(
        "Don't have an account? Register here!",
        style: TextStyle(color: ColorScheme.of(context).error),
      ),
    );
  }
}
