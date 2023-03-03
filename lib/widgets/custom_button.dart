import 'package:flutter/material.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';

class CustomButton extends StatefulWidget {
  String title;

  CustomButton({required this.title});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Container(
        alignment: AlignmentDirectional.center,
        width: width,
        height: height * 0.06,
        decoration: BoxDecoration(
            color: _themeManager.getPrimaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          widget.title,
          style: FontUtils.promptMediumStyle.copyWith(
              fontSize: width * 0.045, color: _themeManager.getWhiteColor),
        ),
      ),
    );
  }
}
