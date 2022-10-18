import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    isLoading.value = true;

    if (authMode == AuthMode.Login) {
    } else {}
    isLoading.value = false;
  }

  AuthMode authMode = AuthMode.Login;
  Map<String, String> authData = {
    'email': '',
    'password': '',
  };
  RxBool isLoading = false.obs;
  final passwordController = TextEditingController();

  void switchAuthMode() {
    if (authMode == AuthMode.Login) {
      authMode = AuthMode.Signup;
    } else {
      authMode = AuthMode.Login;
    }
  }
}

enum AuthMode { Signup, Login }
