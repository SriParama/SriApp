import 'package:clariscoapp/Provider/user_provider.dart';
import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/route/globle_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          
          fontFamily: 'Swansea', // Set default font family
          textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'Swansea',
                bodyColor: GlobalColors.appPrimaryButtonColor
              
              ),
        ),
        
        initialRoute: GlobleRouteNames.authCheckScreen,
        onGenerateRoute: (RouteSettings settings) =>
            GlobleOnGenerateRoutes(routeSettings: settings).routeFunc(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
