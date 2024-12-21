import 'package:clariscoapp/screens/bottom_nav_screen.dart';
import 'package:clariscoapp/screens/Home_Folder/home_screen.dart';
import 'package:clariscoapp/screens/Auth_Folder/login_screen.dart';
import 'package:clariscoapp/screens/Auth_Folder/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/Profile_Folder/profile_screen.dart';

class GlobleRouteNames {
  static const String flashScreen = '/';
  static const String logInScreen = '/logInScreen';
  static const String homeScreen = '/homeScreen';
  static const String registerScreen = '/registerScreen';
  static const String mainNavScreen = '/mainNavScreen';
  static const String authCheckScreen = '/authCheckScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';
}

class GlobleOnGenerateRoutes {
  final RouteSettings routeSettings;
  GlobleOnGenerateRoutes({required this.routeSettings});

  Route<dynamic> routeFunc() {
    Widget screen;

    switch (routeSettings.name) {
      case GlobleRouteNames.logInScreen:
        screen = const LoginScreen();
        break;
      case GlobleRouteNames.authCheckScreen:
        screen = const AuthCheckScreen();
        break;
      case GlobleRouteNames.homeScreen:
        screen = const HomeScreen();
        break;
      case GlobleRouteNames.registerScreen:
        screen = RegisterScreen();
        break;
      case GlobleRouteNames.mainNavScreen:
        screen = const MainNavScreen();
        break;
      case GlobleRouteNames.profileScreen:
        screen = const ProfileScreen();
        break;
      default:
        screen = const Center(
          child: Text('404 Page Not Found'),
        );
        break;
    }
    return MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    );
  }
}

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const MainNavScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
