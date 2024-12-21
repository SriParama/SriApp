import 'package:clariscoapp/core/utils/globle_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../models/goal_model.dart';
import '../../widgets/custom_squareTile.dart';
import '../../widgets/record_not_found_widget.dart';

class ShowGoalScreen extends StatefulWidget {
  const ShowGoalScreen({super.key});

  @override
  State<ShowGoalScreen> createState() => _ShowGoalScreenState();
}

class _ShowGoalScreenState extends State<ShowGoalScreen> {
  final DateFormat customFormat = DateFormat("yyyy-MM-dd hh:mm a");
  String sortOrder = 'Time Left Asc';

  void sortActivities(List<GoalModel> goal) {
    if (sortOrder == 'Time Left Asc') {
      goal.sort((a, b) {
        String dateA = a.process;
        String dateB = b.process;
        return dateA.compareTo(dateB);
      });
    } else if (sortOrder == 'Time Left Desc') {
      goal.sort((a, b) {
        String dateA = a.process;
        String dateB = b.process;
        return dateB.compareTo(dateA);
      });
    }
  }

  // String calculateElapsedTime(String dueDate) {
  //   DateTime taskDate = customFormat.parse(dueDate);
  //   DateTime now = DateTime.now();
  //   Duration difference = taskDate.difference(now);

  //   if (difference.isNegative) {
  //     return 'Over due';
  //   } else if (difference.inMinutes < 60) {
  //     return '${difference.inMinutes} min ';
  //   } else if (difference.inHours < 24) {
  //     return '${difference.inHours} hrs ';
  //   } else {
  //     return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ';
  //   }
  // }
    String calculateGoalElapsedTime(String dueDate) {
    DateTime taskDate = customFormat.parse(dueDate);
    DateTime now = DateTime.now();
    Duration difference = now.difference(taskDate);
    if (difference.isNegative) {
      return 'Over due';
    }
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        sortActivities(value.user!.goals);
        if (value.user!.goals.isEmpty) {
          return const Center(child: RecordNotFoundWidget());
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                child: PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  splashRadius: 0,
                  color: GlobalColors.primaryWhite,
                  onSelected: (value) {
                    setState(() {
                      sortOrder = value;
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sort by process",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Time Left Asc',
                        child: Text('Sort by process (Asc)'),
                      ),
                      const PopupMenuItem(
                        value: 'Time Left Desc',
                        child: Text('Sort by process (Desc)'),
                      ),
                    ];
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.0,
                    mainAxisSpacing: 14.0,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: value.user!.goals.length,
                  itemBuilder: (context, index) {
                    final goals = value.user!.goals[index];
                    return Customsquaretile(
                      titleContent: goals.taskTitle,
                      subContentTitle1: 'Process: ',
                      subContent1: goals.process,
                      subContentTilte2: 'Check in: ',
                      subContent2: calculateGoalElapsedTime(goals.dueDate),

                    );
                  },
                ),
              ),
              const SizedBox(height: 80)
            ],
          ),
        );
      },
    );
  }
}
