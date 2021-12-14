import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  final Color outlineColor;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;

  CustomElevatedButton({
    required this.child,
    required this.onPressed,
    this.color: Colors.white,
    this.outlineColor: Colors.white,
    this.textColor: Colors.black,
    this.height: 50.0,
    this.borderRadius: 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return color;
            },
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: Colors.grey);
            }
            return BorderSide(color: outlineColor);
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return textColor;
            },
          ),
        ),
      ),
    );
  }
}
