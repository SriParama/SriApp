import 'goal_model.dart';
import 'task_model.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String profileImageUrl;
  final List<TaskModel> tasks;
  final List<GoalModel> goals;
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.profileImageUrl,
    required this.tasks,
    required this.goals,
  });
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'],
      profileImageUrl: data['profileImageUrl'],
      tasks: (data['tasks'] as List<dynamic>?)
              ?.map((taskData) => TaskModel.fromFirestore(taskData))
              .toList() ??
          [],
      goals: (data['goals'] as List<dynamic>?)
              ?.map((goalData) => GoalModel.fromFirestore(goalData))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'tasks': tasks.map((task) => task.toMap()).toList(),
      'goals': goals.map((goal) => goal.toMap()).toList(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? profileImageUrl,
    List<TaskModel>? tasks,
    List<GoalModel>? goals,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      tasks: tasks ?? this.tasks,
      goals: goals ?? this.goals,
    );
  }

  List<Map<String, dynamic>> get activityList => [
        {
          'tasks': tasks.map((task) => task.toMap()).toList(),
          'goals': goals.map((goal) => goal.toMap()).toList(),
        }
      ];
}
