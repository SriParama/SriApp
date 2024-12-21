import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider/user_provider.dart';
import '../../core/utils/globle_colors.dart';
import '../../widgets/custom_squareTile.dart';
import '../../widgets/record_not_found_widget.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final DateFormat customFormat = DateFormat("yyyy-MM-dd hh:mm a");
  String sortOrder = 'Time Left Asc';

  void sortActivities(List<Map<String, dynamic>> activities) {
    if (sortOrder == 'Time Left Asc') {
      activities.sort((a, b) {
        DateTime dateA = customFormat.parse(a['dueDate']);
        DateTime dateB = customFormat.parse(b['dueDate']);

        return dateA.compareTo(dateB);
      });
    } else if (sortOrder == 'Time Left Desc') {
      activities.sort((a, b) {
        DateTime dateA = customFormat.parse(a['dueDate']);
        DateTime dateB = customFormat.parse(b['dueDate']);

        return dateB.compareTo(dateA);
      });
    }
  }

  String calculateElapsedTime(String dueDate) {
    DateTime taskDate = customFormat.parse(dueDate);
    DateTime now = DateTime.now();
    Duration difference = taskDate.difference(now);

    if (difference.isNegative) {
      return 'Over due';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ';
    }
  }

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
        List<Map<String, dynamic>> activities = [
          ...value.user!.tasks.map((task) => {
                'type': 'Task',
                ...task.toMap(),
              }),
          ...value.user!.goals.map((goal) => {
                'type': 'Goal',
                ...goal.toMap(),
              }),
        ];

        sortActivities(activities);
        if (value.user!.tasks.isEmpty && value.user!.goals.isEmpty) {
          return const RecordNotFoundWidget();
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
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
                      Text(
                        "Sort by time",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Time Left Asc',
                        child: Text('Sort by time (Asc)'),
                      ),
                      const PopupMenuItem(
                        value: 'Time Left Desc',
                        child: Text('Sort by time (Desc)'),
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
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return Customsquaretile(
                      titleContent: activity['taskTitle'] ?? 'No Title',
                      subContentTitle1: activity['type'] == 'Task'
                          ? "Priority: "
                          : activity['type'] == 'Goal'
                              ? 'Process: '
                              : '',
                      subContent1: activity['type'] == 'Task'
                          ? activity['priority']
                          : activity['type'] == 'Goal'
                              ? activity['process']
                              : '',
                      subContentTilte2: activity['type'] == 'Task'
                          ? 'Time left: '
                          : activity['type'] == 'Goal'
                              ? 'Check in: '
                              : '',
                      subContent2: activity['type'] == 'Task'
                          ? calculateElapsedTime(activity['dueDate'])
                          : activity['type'] == 'Goal'
                              ? calculateGoalElapsedTime(activity['dueDate'])
                              : '',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
