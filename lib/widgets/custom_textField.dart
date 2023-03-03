import 'package:flutter/material.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  bool obscureText;
  bool obSecure;
  bool isActive;
  String hintText;
  TextInputType keyboardType;
  Function validator;
  int numberOfLine;

  CustomTextField(
      {required this.controller,
      required this.obscureText,
      required this.obSecure,
      required this.hintText,
      required this.keyboardType,
      required this.validator,
      required this.numberOfLine,
      required this.isActive});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isActive,
      maxLines: widget.numberOfLine,
      controller: widget.controller,
      obscureText: widget.obSecure,
      style: FontUtils.promptSemiBoldStyle
          .copyWith(color: _themeManager.getBlackColor, fontSize: width * 0.04),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintStyle: FontUtils.promptRegularStyle
            .copyWith(color: _themeManager.getGreyFontColor),
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: _themeManager.getLightGreyBorderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: _themeManager.getLightGreyBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: _themeManager.getLightGreyBorderColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: _themeManager.getLightGreyBorderColor)),
        suffixIcon: widget.obscureText
            ? widget.obSecure
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.obSecure = false;
                      });
                    },
                    child: Icon(
                      Icons.visibility_off_outlined,
                      color: _themeManager.getLightGreyBorderColor,
                      size: width * 0.055,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.obSecure = true;
                      });
                    },
                    child: Icon(
                      Icons.visibility_outlined,
                      color: _themeManager.getLightGreyBorderColor,
                      size: width * 0.055,
                    ),
                  )
            : Container(
                height: 0.0,
                width: 0.0,
              ),
      ),
      cursorColor: _themeManager.getBlackColor,
      validator: (value) {
        if (widget.validator() != null) {
          return widget.validator().toString();
        } else {
          return null;
        }
      },
    );
  }
}
