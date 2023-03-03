import 'dart:io';

import 'package:flutter/material.dart';

import '../model/user_model.dart';

abstract class AuthRepo {
  // ----------- login the user -----------------
  Future loginController({required String email, required String password});

  // ----------- login the user -----------------
  Future logOutController();

  // ----------- signup the user -----------------
  Future signupController(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});

  // ----------- edit profile -----------------
  void EditProfileController({
    required String firstName,
    required String lastName,
  });

  // ----------- set user data -------------------
  Future setUserDataController(UserModel userModel);

  // ----------- add user profile image ---------------
  addProfileImageController(
      File image, BuildContext context, UserModel userModel);

  // ----------- get user data ------------------
  Future getUserDataController();

  // ----------- resetPassword link ---------------
  Future resetPasswordController(String email);

  // ----------- change Password ---------------
  Future changePasswordController(String password);
}
