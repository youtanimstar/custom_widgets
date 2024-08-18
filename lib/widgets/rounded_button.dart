import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnName;
  final Icon? btnIcon;
  final Color? bgColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final VoidCallback? callback;
  final double? padding;
  final double? gap;

  const RoundedButton(
      {super.key,
      required this.btnName,
      this.btnIcon,
      this.bgColor = Colors.black,
      this.textStyle = const TextStyle(color: Colors.white),
      this.borderRadius = 5.0,
      required this.callback,
      this.padding = 8.0,
      this.gap = 8.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback!();
      },
      style: ElevatedButton.styleFrom(
        // Background color
        backgroundColor: bgColor,
        textStyle: textStyle, // Text style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!), // Rounded corners
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding!),
        child: btnIcon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnIcon!,
                  SizedBox(width: gap), // Space between icon and text
                  Text(
                    btnName,
                    style: textStyle,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    btnName,
                    style: textStyle,
                  ),
                ],
              ),
      ),
    );
  }
}
