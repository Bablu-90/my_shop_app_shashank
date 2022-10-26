import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/screens/auth_screen.dart';
import 'package:my_shop_app/screens/splash_screen.dart';

class AuthScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  final RxBool isLoading = false.obs;

  RxString get userId {
    return userId;
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    isLoading.value = true;

    if (authMode == AuthMode.Login) {
      AuthScreenController authScreenController = Get.find();
      await authScreenController
          .login(signUpEmailController.text, signUpPasswordController.text)
          .obs;
    } else {
      AuthScreenController authScreenController = Get.find();
      await authScreenController
          .signup(signUpEmailController.text, signUpPasswordController.text)
          .obs;
    }
    isLoading.value = false;
  }

  AuthMode authMode = AuthMode.Login;
  RxMap<String, String> authData = {
    'email': '',
    'password': '',
  }.obs;

  void switchAuthMode() {
    if (authMode == AuthMode.Login) {
      authMode = AuthMode.Signup;
    } else {
      authMode = AuthMode.Login;
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.to(() => SplashScreen());
      });
    } catch (e) {
      Get.snackbar('About SignUp', 'User SignUp message',
          backgroundColor: Colors.deepOrange.shade200,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Sign Up failed',
            style: TextStyle(color: Colors.black54),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white54),
          ));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.to(() => SplashScreen());
      });
    } catch (e) {
      Get.snackbar('About Login', 'Login message',
          backgroundColor: Colors.redAccent.shade200,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Login failed',
            style: TextStyle(color: Colors.black),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white38),
          ));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAll(() => AuthScreen()));
  }
//void fetch

}

enum AuthMode { Signup, Login }
