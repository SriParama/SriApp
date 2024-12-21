import 'package:clariscoapp/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/route/globle_route.dart';
import '../../core/utils/globle_colors.dart';
import 'overview_screen.dart';
import 'upcoming_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: GlobalColors.appbgColor,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Hello,",
                                  style: TextStyle(
                                      color: GlobalColors.appPrimaryButtonColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Expanded(child: Text("")),
                                const Icon(
                                  Icons.notifications_sharp,
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        GlobleRouteNames.profileScreen);
                                  },
                                  child: CircleAvatar(
                                      backgroundImage: userProvider.file == null
                                          ? null
                                          : FileImage(userProvider.file!),
                                      backgroundColor:
                                          GlobalColors.appPrimaryButtonColor,
                                      radius: 20,
                                      child: Text(
                                        userProvider.file == null
                                            ? userProvider.user!.displayName
                                                .substring(0, 1)
                                                .toUpperCase()
                                            : "",
                                        style: const TextStyle(
                                            height: -0.2,
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                            Text(
                              userProvider.user?.displayName ?? '',
                              style: const TextStyle(
                                  color: GlobalColors.appPrimaryButtonColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: GlobalColors.appPrimaryTitleColor),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.3,
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(0),
                          indicator: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          unselectedLabelColor:
                              GlobalColors.appPrimaryButtonColor,
                          labelColor: Colors.white,
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          tabs: const [
                            Tab(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Text('Overview')),
                            ),
                            Tab(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  child: Text('Upcoming')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 60,
                      child: TabBarView(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                top: 30,
                              ),
                              child: OverviewScreen()),
                          UpcomingScreen(),
                        ],
                      ),
                    ),
                     const SizedBox(height: 80)
                  ],
                ),
              )),
        );
      },
    );
  }
}
