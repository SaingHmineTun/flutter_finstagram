import 'package:flutter/material.dart';

class MaoTextFormField extends StatelessWidget {
  late String title;
  late bool obscureText;
  Function(String?) validator;
  Function(String?) onSave;

  MaoTextFormField({
    super.key,
    required this.title,
    this.obscureText = false,
    required this.validator,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxWidth: 350),
      child: TextFormField(
        onSaved: (val) {
          onSave(val);
        },
        validator: (value) {
          return validator(value);
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(title),
          border: OutlineInputBorder(),
        ),
      ),
    );
    ;
  }
}
