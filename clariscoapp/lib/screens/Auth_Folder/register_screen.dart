import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../core/route/globle_route.dart';
import '../../core/utils/globle_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  void register(context) async {
    if (_formKey.currentState!.validate()) {
      loadingDailogWithCircle(context);
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'displayName': _nameController.text,
          'profileImageUrl': '',
          'uid': uid,
          'tasks': [],
          'goals': [],
        });

        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            Provider.of<UserProvider>(context, listen: false)
                .setUserDetails(user);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: EdgeInsets.only(left: 30.0, bottom: 30),
                      child: Text('Create Account',
                          style: TextStyle(
                              color: GlobalColors.primaryTextColor
                                  .withOpacity(0.8),
                              fontSize: 35)),
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
                            controller: _nameController,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter Name' : null,
                            labelText: 'Name',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: GlobalColors.appSecondryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
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
                              text: 'Create Account',
                              onPressed: () => register(context),
                            ),
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
                  "Already have an account?",
                  style: TextStyle(
                      color: GlobalColors.primaryTextColor, fontSize: 15),
                ),

                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    GlobleRouteNames.logInScreen,
                  ),
                  child:const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.appSecondryColor,
                        fontSize: 16),
                  ),
                )

                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
