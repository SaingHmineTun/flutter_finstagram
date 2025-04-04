import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/widgets/app_bar_widget.dart';
import 'package:finstagram/widgets/mao_button.dart';
import 'package:finstagram/widgets/mao_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceWidth, _deviceHeight;
  File? _imageFile;
  String? _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(context, _deviceHeight * 0.15),
      body: _registerForm(),
    );
  }

  Widget _registerForm() {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _profilePicture(),
          _nameFormField(),
          _emailField(),
          _passwordField(),
          _registerButton(),
        ],
      ),
    );
  }

  void _chooseImageFile() {
    FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image)
        .then((val) {
          if (val != null) {
            setState(() {
              _imageFile = File(val.files.first.path!);
            });
          }
        });
  }

  Widget _registerButton() {
    return MaoButton(onClick: () {}, text: "Register", width: _deviceWidth);
  }

  Widget _nameFormField() {
    return MaoTextFormField(
      title: "Enter your name",
      validator: (val) {
        return val!.length >= 4 ? null : "Name must be at least 4 characters";
      },
      onSave: (val) {
        _name = val;
      },
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
        _email = val;
      },
    );
  }

  Widget _passwordField() {
    return MaoTextFormField(
      obscureText: true,
      title: "Enter your password",
      validator: (val) {
        return val!.length > 4
            ? null
            : "Password must be at least 5 characters";
      },
      onSave: (val) {
        _password = val;
      },
    );
  }

  Widget _profilePicture() {
    ImageProvider image;
    if (_imageFile == null) {
      image = NetworkImage("https://i.pravatar.cc/300");
    } else {
      image = FileImage(_imageFile!);
    }
    return GestureDetector(
      onTap: _chooseImageFile,
      child: Container(
        constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
        width: _deviceWidth * 0.4,
        height: _deviceWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ColorScheme.of(context).error, width: 3),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
