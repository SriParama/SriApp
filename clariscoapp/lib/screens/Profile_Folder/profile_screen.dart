import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:clariscoapp/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../core/route/globle_route.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _displayEditController = TextEditingController();
  bool displayNameEdit = false;
  logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully.')),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        GlobleRouteNames.logInScreen,
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  editProfile() {
    setState(() {
      displayNameEdit = !displayNameEdit;
    });
    Provider.of<UserProvider>(context, listen: false)
        .updateDisplayName(_displayEditController.text);
  }

  @override
  Widget build(BuildContext context) {
    List l = List.generate(
      25,
      (index) => index,
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          _displayEditController.text = userProvider.user!.displayName;
          if (userProvider.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                      backgroundImage: userProvider.file == null
                                          ? null
                                          : FileImage(userProvider.file!),
                                      backgroundColor:
                                          GlobalColors.appPrimaryButtonColor,
                                      radius: 55,
                                      child: Text(
                                        userProvider.file == null
                                            ? userProvider.user!.displayName
                                                .substring(0, 1)
                                                .toUpperCase()
                                            : "",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )),
                                  Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: InkWell(
                                      onTap: () => userProvider.pickFile(),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          color:
                                              GlobalColors.appPrimaryTitleColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.mode_edit,
                                          color: GlobalColors.primaryWhite,
                                          size: 17,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    letterSpacing: 1.1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.appPrimaryButtonColor),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    isDense: true,
                                    border: displayNameEdit
                                        ? const UnderlineInputBorder()
                                        : InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 5),
                                    enabled: displayNameEdit),
                                controller: _displayEditController,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                userProvider.user!.email,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomMaterialButton(
                                  color: GlobalColors.appPrimaryButtonColor,
                                  borderRadius: 20,
                                  text: displayNameEdit
                                      ? 'Save Name'
                                      : 'Edit Name',
                                  onPressed: () {
                                    editProfile();
                                  })
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                          'Do you want to Logout ?',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color:
                                                  GlobalColors.primaryTextColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          SizedBox(
                                            height: 25.0,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    18.0))),
                                                    backgroundColor:
                                                        const WidgetStatePropertyAll(
                                                            GlobalColors
                                                                .appbgColor)),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('No',
                                                    style: TextStyle(
                                                        fontFamily: 'inter',
                                                        fontSize: 12.0,
                                                        color: GlobalColors
                                                            .appPrimaryButtonColor))),
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0))),
                                                    backgroundColor:
                                                        const WidgetStatePropertyAll(
                                                            GlobalColors
                                                                .appPrimaryButtonColor)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();

                                                  logout(context);
                                                },
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      fontFamily: 'inter',
                                                      fontSize: 12.0,
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          GlobalColors.appPrimaryButtonColor,
                                      child: Icon(
                                        Icons.power_settings_new_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Log Out",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: Text(""))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Your Badges",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        spacing: MediaQuery.of(context).size.width * 0.04,
                        runSpacing: MediaQuery.of(context).size.width * 0.05,
                        children: l
                            .map((e) => Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Icon(
                                    size: 50,
                                    GlobalColors.getRandomIcon(),
                                    color: GlobalColors.getRandomBrightColor(),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ))
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
