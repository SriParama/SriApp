class TaskModel {
  final String taskTitle;
  final String taskLocation;
  final String dueDate;
  final String priority;
  final String recuring;

  TaskModel({
    required this.taskTitle,
    required this.taskLocation,
    required this.dueDate,
    required this.priority,
    required this.recuring,
  });

  factory TaskModel.fromFirestore(Map<String, dynamic> data) {
    return TaskModel(
      taskTitle: data['taskTitle'],
      taskLocation: data['taskLocation'],
      dueDate: data['dueDate'],
      priority: data['priority'],
      recuring: data['recuring'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'taskLocation': taskLocation,
      'dueDate': dueDate,
      'priority': priority,
      'recuring': recuring,
    };
  }
}
