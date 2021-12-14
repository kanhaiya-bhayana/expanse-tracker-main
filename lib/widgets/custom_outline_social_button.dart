import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class CustomOutLineSocialButton extends CustomElevatedButton {
  final String text;
  final VoidCallback? onPressed;
  final String? assetName;
  final Color outlineColor;
  final Color backgroundColor;
  final Color textColor;

  CustomOutLineSocialButton({
    required this.text,
    required this.onPressed,
    this.assetName,
    required this.outlineColor,
    this.backgroundColor: Colors.white,
    this.textColor: Colors.white,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              assetName != null
                  ? onPressed == null
                      ? Opacity(opacity: 0.7, child: Image.asset(assetName))
                      : Image.asset(assetName)
                  : Container(
                      height: 0,
                    ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: assetName != null
                    ? Image.asset(assetName)
                    : Container(
                        height: 0,
                      ),
              )
            ],
          ),
          onPressed: onPressed,
          borderRadius: 40.0,
          outlineColor: outlineColor,
          textColor: outlineColor,
          color: backgroundColor,
        );
}
