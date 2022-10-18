import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/screens/widgets/auth_controller.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthScreenController authScreenController = Get.put(AuthScreenController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: authScreenController.authMode == AuthMode.Signup ? 320 : 260,
        constraints: BoxConstraints(
            minHeight:
                authScreenController.authMode == AuthMode.Signup ? 320 : 260),
        width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: authScreenController.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    authScreenController.authData['email'] = value.toString();
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: authScreenController.passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    authScreenController.authData['Password'] =
                        value.toString();
                  },
                ),
                if (authScreenController.authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: authScreenController.authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: authScreenController.authMode == AuthMode.Signup
                        ? (value) {
                            if (value !=
                                authScreenController.passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (authScreenController.isLoading.value)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      authScreenController.submit();
                    },
                    child: Text(authScreenController.authMode == AuthMode.Login
                        ? 'Login'
                        : 'Sign Up'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
