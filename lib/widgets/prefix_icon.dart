import 'package:flutter/material.dart';

import '../utils/app_const.dart';
import '../utils/app_textStyle.dart';

class PrifixIcon extends StatefulWidget {
  @override
  _PrifixIconState createState() => _PrifixIconState();
}

class _PrifixIconState extends State<PrifixIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(left: width * 0.012),
        child: Row(children: [
          Icon(
            Icons.arrow_back_ios,
            size: width * 0.042,
          ),
          Text(
            "Back",
            style: FontUtils.promptSemiBoldStyle.copyWith(),
          )
        ]),
      ),
    );
  }
}
