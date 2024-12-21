import 'dart:io';

import 'package:clariscoapp/models/goal_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';
import '../models/user_models.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  File? file;
  UserModel? get user => _user;
  Future<void> setUserDetails(User firebaseUser) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(firebaseUser.email)
          .get();

      if (userDoc.exists) {
        _user = UserModel.fromFirestore(userDoc.data()!);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUser.email)
          .set(updatedUser.toMap());

      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating user details: $e');
    }
  }

  void updateDisplayName(String newName) {
    if (_user != null) {
      _user = _user!.copyWith(displayName: newName);
      updateUserDetails(_user!);
    }
  }

  void addTask(TaskModel newTask) {
    if (_user != null) {
      _user!.tasks.add(newTask);
      updateUserDetails(_user!);
    }
  }

  void addGoal(GoalModel newGoal) {
    if (_user != null) {
      _user!.goals.add(newGoal);
      updateUserDetails(_user!);
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        file = File(result.files.single.path!);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }
}
