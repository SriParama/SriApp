import 'package:clariscoapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Provider/task_provider.dart';
import '../../Provider/user_provider.dart';
import '../../core/utils/globle_colors.dart';
import '../../models/task_model.dart';
import '../../widgets/add_task_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/tab_button_widget.dart';

class AddNewTaskPage extends StatelessWidget {
  AddNewTaskPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> setPriorityArr = ['High', 'Moderate', 'Low'];
  final List<String> makeRecuringArr = ['Never', 'Daily', 'Weekly', 'Monthly'];

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }

  Future<void> selectDueDate(context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        _dueDateController.text = formatDateTime(combinedDateTime);
      }
    }
  }

  void saveTask(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        Provider.of<UserProvider>(context, listen: false).addTask(TaskModel(
            taskTitle: _titleController.text,
            taskLocation: _locationController.text,
            dueDate: _dueDateController.text,
            priority: setPriorityArr[TaskProvider().selectedPriorityIndex],
            recuring:
                makeRecuringArr[TaskProvider().selectedMakeRecurringIndex]));

        _titleController.clear();
        _locationController.clear();
        _dueDateController.clear();
      

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save task: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return Container(
            color:  GlobalColors.appbgColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const  Text(
                        'Enter a title',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      ),
                      CustomAddCardWidget(
                        child: CustomTextFormField(
                          controller: _titleController,
                          hintText: 'Title',
                          validator: (value) =>
                              value!.isEmpty ? 'Enter Title' : null,
                          filled: true,
                          filledColor: GlobalColors.primaryWhite,
                          borderEnable: false,
                        ),
                      ),
                      const Text(
                        'Select a time',
                        style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      CustomAddCardWidget(
                        child: GestureDetector(
                          onTap: () => selectDueDate(context),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: _dueDateController,
                              readOnly: true,
                              validator: (value) =>
                                  value!.isEmpty ? 'Select a due date' : null,
                              hintText: 'Due Date and Time',
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined),
                              filled: true,
                              filledColor: GlobalColors.primaryWhite,
                              borderEnable: false,
                            ),
                          ),
                        ),
                      ),
                   
                      const Text(
                        'Enter a Location',
                        style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      CustomAddCardWidget(
                        child: CustomTextFormField(
                          controller: _locationController,
                          hintText: 'Location',
            
                          validator: (value) =>
                              value!.isEmpty ? 'Enter Location' : null,
                          // labelText: 'Location',
                          filled: true,
                          filledColor: GlobalColors.primaryWhite,
                          borderEnable: false,
                        ),
                      ),
                      const Text(
                        'Set priority',
                        style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      CustomAddCardWidget(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: setPriorityArr.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  taskProvider.selectedPriorityIndex == index;
                              return InkWell(
                                onTap: () {
                                  taskProvider.updatePriorityIndex(index);
                                },
                                child: TabContainerWidget(
                                  isSelected: isSelected,
                                  text: setPriorityArr[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Text(
                        'Make recurring',
                        style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      CustomAddCardWidget(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: makeRecuringArr.length,
                            itemBuilder: (context, index) {
                              final isSelected =
                                  taskProvider.selectedMakeRecurringIndex ==
                                      index;
                              return InkWell(
                                onTap: () {
                                  taskProvider.updateMakeRecurringIndex(index);
                                },
                                child: TabContainerWidget(
                                  isSelected: isSelected,
                                  text: makeRecuringArr[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: CustomMaterialButton(
                            borderRadius: 50,
                            color: GlobalColors.appPrimaryButtonColor,
                            text: 'Save task',
                            onPressed: () => saveTask(context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
