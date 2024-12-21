class GoalModel {
  final String taskTitle;
  final String taskLocation;
  final String dueDate;
  final String process;

  GoalModel({
    required this.taskTitle,
    required this.taskLocation,
    required this.dueDate,
    required this.process,
  });
  factory GoalModel.fromFirestore(Map<String, dynamic> data) {
    return GoalModel(
      taskTitle: data['taskTitle'],
      taskLocation: data['taskLocation'],
      dueDate: data['dueDate'],
      process: data['process'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'taskLocation': taskLocation,
      'dueDate': dueDate,
      'process': process,
    };
  }
}
