import 'package:clariscoapp/core/route/globle_route.dart';
import 'package:clariscoapp/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../core/utils/globle_colors.dart';
import '../../widgets/app_exit_widget.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  DateTime goBackApp = DateTime.now();
  
  void login(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        loadingDailogWithCircle(context);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          GlobleRouteNames.mainNavScreen,
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email format.';
        } else {
          errorMessage = 'Please Enter Correct login credentials';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

  willPop() {
    if (DateTime.now().isBefore(goBackApp)) {
      SystemNavigator.pop();
      return true;
    }
    goBackApp = DateTime.now().add(const Duration(seconds: 2));
    appExit(
      context,
      "Press again to Exit",
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        willPop();
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: GlobalColors.appPrimaryColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 30),
                        child: Text('Login',
                            style: TextStyle(
                                color: GlobalColors.primaryTextColor
                                    .withOpacity(0.8),
                                fontSize: 40)),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: GlobalColors.primaryWhite),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              controller: _emailController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Email' : null,
                              labelText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: GlobalColors.appSecondryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              isPassword: isPasswordVisible,
                              labelText: 'Password',
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Password' : null,
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: GlobalColors.appSecondryColor,
                              ),
                              suffixIcon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: GlobalColors.appSecondryColor,
                              ),
                              onSuffixIconTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              child: CustomMaterialButton(
                                padding: EdgeInsets.zero,
                                color: GlobalColors.appSecondryColor,
                                textColor: GlobalColors.primaryWhite,
                                text: 'Login',
                                onPressed: () => login(context),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: GlobalColors.primaryTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: GlobalColors.primaryTextColor, fontSize: 15),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      GlobleRouteNames.registerScreen,
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.appSecondryColor,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
