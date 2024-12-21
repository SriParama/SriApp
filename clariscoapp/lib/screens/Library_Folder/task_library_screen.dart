
import 'package:clariscoapp/screens/Library_Folder/show_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/tab_provider.dart';
import '../../core/utils/globle_colors.dart';
import 'show_goal_screen.dart';

class TaskLibraryScreen extends StatelessWidget {
  const TaskLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = ['Task', 'Goal'];

    return ChangeNotifierProvider(
      create: (_) => TabsProvider(),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: GlobalColors.appbgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: GlobalColors.appbgColor,
          title: const Text(
            "Library",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: GlobalColors.appPrimaryTitleColor),
          ),
          actions: [
            Consumer<TabsProvider>(
              builder: (context, tabsProvider, child) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  width: 150,
                  height: 40,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      final isSelected =
                          tabsProvider.selectedTaksLibrary == index;
                      return InkWell(
                        onTap: () {
                          tabsProvider.setLibraryTaskTab(index);
                        },
                        child: Card(
                          elevation: 0,
                          color: isSelected
                              ? GlobalColors
                                  .appPrimaryButtonColor // Selected color
                              : Colors.transparent, // Default color
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected
                                    ? GlobalColors.primaryWhite
                                    : GlobalColors.primaryTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<TabsProvider>(
          builder: (context, tabsProvider, child) {
            if (tabsProvider.selectedTaksLibrary == 0) {
              return const ShowTaskScreen();
            } else if (tabsProvider.selectedTaksLibrary == 1) {
              return const ShowGoalScreen();
            }
            return Container();
          },
        ),
       
      ),
    );
  }
}
