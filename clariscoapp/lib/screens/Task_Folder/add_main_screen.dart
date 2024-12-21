
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/tab_provider.dart';
import '../../core/utils/globle_colors.dart';
import 'add_goal_page.dart';
import 'add_task_page.dart'; // Replace with actual widget for goal tab

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
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
          backgroundColor:  GlobalColors.appbgColor,
          automaticallyImplyLeading: false,
          title:  const Text(
            'New task / goal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: GlobalColors.appPrimaryTitleColor,
            ),
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
                      final isSelected = tabsProvider.selectedTab == index;
                      return InkWell(
                        onTap: () {
                          tabsProvider.setTab(index);
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
            if (tabsProvider.selectedTab == 0) {
              return AddNewTaskPage();
            } else if (tabsProvider.selectedTab == 1) {
              return AddNewGoalPage(); 
            }
            return Container(); 
          },
        ),
      ),
    );
  }
}


