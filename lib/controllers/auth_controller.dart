import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nftapp/model/user_model.dart';
import 'package:nftapp/repository/auth_repo.dart';
import 'package:nftapp/services/auth_service.dart';
import 'package:nftapp/services/product_service.dart';
import 'package:nftapp/utils/app_const.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends AuthRepo with ChangeNotifier {
  AuthenticationService _authService = AuthenticationService();
  UserModel userModel = UserModel();
  bool isLoading = true;

  // ------------- login controller -------------
  @override
  Future loginController(
      {required String email, required String password}) async {
    var response =
        await _authService.loginWithEmail(email: email, password: password);
    if (response != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Session().isLogin, "true");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Invalid credentials");
      return false;
    }
  }

  // ------------- signup controller -------------

  @override
  Future signupController({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    var response =
        await _authService.signUpWithEmail(email: email, password: password);
    if (response != null) {
      userModel =
          UserModel(email: email, lastName: lastName, firstName: firstName);
      setUserDataController(userModel);
      Fluttertoast.showToast(msg: "Signup Successfully");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Please try again");
      return false;
    }
  }

  // ------------- set user data controller -------------
  @override
  Future setUserDataController(UserModel userModel) async {
    _authService.setUserData(userModel);
    getUserDataController();
  }

  // ------------- get user data controller -------------
  @override
  Future getUserDataController() async {
    isLoading = true;
    _authService.getUserData().then((value) {
      userModel = UserModel.fromJson(value!);
      notifyListeners();
    });
    isLoading = false;
  }

  // ------------- logout controller -------------
  @override
  Future logOutController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Session().isLogin, "false");
  }

  // ------------- edit user profile controller -------------
  @override
  EditProfileController({required String firstName, required String lastName}) {
    userModel.firstName = firstName;
    userModel.lastName = lastName;
    setUserDataController(userModel);
  }

  // --------- add user profile controller --------------
  @override
  Future addProfileImageController(
      File image, BuildContext context, UserModel userModel) async {
    String fileName = basename(image.path);
    await ProductService().addImage(image, "$fileName").then((value) async {
      userModel.profilePicture = await value;
      setUserDataController(userModel);
    });
  }

  // -------------- reset password controller ----------
  @override
  Future resetPasswordController(String email) async {
    await _authService.resetPassword(email);
  }

  // --------------- change password controller ----------
  @override
  Future changePasswordController(String password) async {
    _authService.changePassword(password: password).then((value) {
      if (value == true) {
        Fluttertoast.showToast(msg: "Password updated successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "Please try again in sometime");
        return false;
      }
    });
  }
}
