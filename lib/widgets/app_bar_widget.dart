import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, double deviceHeight) {
  return AppBar(
    centerTitle: true,
    backgroundColor: ColorScheme.of(context).primary,
    foregroundColor: ColorScheme.of(context).onPrimary,
    title: Text("Finstagram", style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),),
    toolbarHeight: deviceHeight,
  );
}