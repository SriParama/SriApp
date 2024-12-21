import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/user_provider.dart';
import '../../core/utils/globle_colors.dart';
import '../../models/task_model.dart';
import '../../widgets/custom_squareTile.dart';
import '../../widgets/record_not_found_widget.dart';

class ShowTaskScreen extends StatefulWidget {
  const ShowTaskScreen({super.key});

  @override
  State<ShowTaskScreen> createState() => _ShowTaskScreenState();
}

class _ShowTaskScreenState extends State<ShowTaskScreen> {
  final DateFormat customFormat = DateFormat("yyyy-MM-dd hh:mm a");
  String sortOrder = 'Time Left Asc';

  void sortActivities(List<TaskModel> task) {
    if (sortOrder == 'Time Left Asc') {
      task.sort((a, b) {
        DateTime dateA = customFormat.parse(a.dueDate);
        DateTime dateB = customFormat.parse(b.dueDate);
        return dateA.compareTo(dateB);
      });
    } else if (sortOrder == 'Time Left Desc') {
      task.sort((a, b) {
        DateTime dateA = customFormat.parse(a.dueDate);
        DateTime dateB = customFormat.parse(b.dueDate);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        sortActivities(value.user!.tasks);
        if (value.user!.tasks.isEmpty) {
          return const Center(child:  RecordNotFoundWidget());
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
    
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10.0,bottom: 10.0),
                child: PopupMenuButton<String>(
                  splashRadius: 0,
                  position: PopupMenuPosition.under,
                   
                    color:  GlobalColors.primaryWhite,
                  onSelected: (value) {
                    setState(() {
                      sortOrder = value;
                    });
                  },
                  child: const Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sort by time",style: TextStyle(fontWeight: FontWeight.bold)),
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
                  itemCount: value.user!.tasks.length,
                  itemBuilder: (context, index) {
                    final tasks = value.user!.tasks[index];
                    return Customsquaretile(
                      titleContent: tasks.taskTitle,
                      subContentTitle1: 'Priority: ',
                      subContent1: tasks.priority,
                      subContentTilte2: 'Time left: ',
                      subContent2: calculateElapsedTime(tasks.dueDate),
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
