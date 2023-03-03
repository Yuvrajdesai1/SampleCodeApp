import 'package:flutter/material.dart';

import '../utils/app_const.dart';
import '../utils/app_textStyle.dart';
import '../utils/theme_manager.dart';

class CustomSearch extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  Function onChanged;
  Color backgroundColor;

  CustomSearch(
      {required this.controller,
      required this.hintText,
      required this.onChanged,
      required this.backgroundColor});

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.03)),
      elevation: 5,
      child: TextFormField(
        controller: widget.controller,
        style: FontUtils.promptSemiBoldStyle.copyWith(
            color: _themeManager.getBlackColor, fontSize: width * 0.04),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: widget.backgroundColor,
          filled: true,
          prefixIcon: Image.asset("assets/icons/search.png",
              color: _themeManager.getBlackColor),
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
        ),
        cursorColor: _themeManager.getBlackColor,
        onChanged: (value) {
          /* if (widget.onChanged() != null) {
            return "";
          } else {
            return null;
          }*/
        },
      ),
    );
  }
}
