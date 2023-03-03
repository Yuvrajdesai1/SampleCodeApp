import 'package:flutter/material.dart';

import 'package:nftapp/utils/app_textStyle.dart';
import 'package:nftapp/utils/theme_manager.dart';

AppBar CustomAppBar({required String title, required Widget prefixIcon, required Widget actions}) {
  return AppBar(
    elevation: 0,
    backgroundColor: ThemeManager().getPrimaryColor,
    title: Text(
      title,
      style: FontUtils.promptSemiBoldStyle
          .copyWith(color: ThemeManager().getWhiteColor),
    ),
    centerTitle: true,
    leading: prefixIcon,
    actions: [
  actions
    ],
  );
}
