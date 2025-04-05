import 'package:finstagram/services/firebase_service.dart';
import 'package:finstagram/widgets/app_bar_widget.dart';
import 'package:finstagram/widgets/mao_button.dart';
import 'package:finstagram/widgets/mao_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late FirebaseService firebaseService;

  @override
  void initState() {
    super.initState();
    firebaseService = GetIt.instance.get<FirebaseService>();
  }

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
          firebaseService.login(email, password).then((loginSuccess) {
            if (context.mounted) {
              if (loginSuccess) {
                message = "Login success";
                Navigator.popAndPushNamed(context, "home");
              } else {
                message = "Incorrect email or password";
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            }
          });
        } else {
          message = "Login failed";
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
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
        if (val != null) email = val;
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
        if (val != null) password = val;
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
