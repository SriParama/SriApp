
import 'package:flutter/material.dart';

class TabsProvider with ChangeNotifier {
  int _selectedTab = 0;
   int _selectedTaksLibrary = 0;


  int get selectedTab => _selectedTab;
  int get selectedTaksLibrary => _selectedTaksLibrary;

  void setTab(int tabIndex) {
    _selectedTab = tabIndex;
    notifyListeners();
  }
  void setLibraryTaskTab(int tabIndex) {
    _selectedTaksLibrary = tabIndex;
    notifyListeners();
  }
}
