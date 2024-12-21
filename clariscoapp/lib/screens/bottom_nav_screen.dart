import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Provider/user_provider.dart';
import '../widgets/app_exit_widget.dart';
import 'Library_Folder/task_library_screen.dart';
import 'Home_Folder/home_screen.dart';
import 'Task_Folder/add_main_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 1; // Default to HomeScreen
  final _screens = [
    const AddTaskScreen(),
    const HomeScreen(),
    const TaskLibraryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setUserDetails(context);
  }

  void setUserDetails(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<UserProvider>().setUserDetails(user);
    }
  }

  DateTime goBackApp = DateTime.now();

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
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: Stack(
          children: [
            _screens[_currentIndex],
            Positioned(
              bottom: 10,
              left: 30,
              right: 30,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: GlobalColors.primaryWhite),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavButton(
                      icon: Icons.add,
                      label: 'Add Task',
                      isActive: _currentIndex == 0,
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                    _buildNavButton(
                      icon: Icons.home_sharp,
                      label: '',
                      isActive: _currentIndex == 1,
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                    _buildNavButton(
                      icon: Icons.library_books,
                      label: 'Library',
                      isActive: _currentIndex == 2,
                      onTap: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: isActive
            ? GlobalColors.appPrimaryButtonColor
            : const Color.fromARGB(255, 210, 209, 209),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
