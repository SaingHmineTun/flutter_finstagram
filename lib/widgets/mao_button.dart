import 'package:flutter/material.dart';

class MaoButton extends StatelessWidget {
  Function onClick;
  String text;
  Color? bgColor;
  Color? textColor;
  double? width;
  double? height;

  MaoButton({
    super.key,
    required this.onClick,
    required this.text,
    this.bgColor,
    this.textColor,
    this.width,
    this.height = 50
  });

  @override
  Widget build(BuildContext context) {
    bgColor ??= ColorScheme.of(context).primary;
    textColor ??= ColorScheme.of(context).onPrimary;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 350
      ),
      child: MaterialButton(

        onPressed: () => onClick(),
        height: 50,
        minWidth: width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: bgColor,
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
