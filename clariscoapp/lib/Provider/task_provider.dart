import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  int _selectedMakeRecurringIndex = 0;
  int _selectedPriorityIndex = 0;

  int get selectedMakeRecurringIndex => _selectedMakeRecurringIndex;
  int get selectedPriorityIndex => _selectedPriorityIndex;

  void updateMakeRecurringIndex(int index) {
    _selectedMakeRecurringIndex = index;
    notifyListeners();
  }

  void updatePriorityIndex(int index) {
    _selectedPriorityIndex = index;
    notifyListeners();
  }
}
