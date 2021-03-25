import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/screens/auth/register_user/register_user_view.dart';
import 'package:frontend/src/screens/main/home/home_view.dart';
import 'package:frontend/src/screens/main/widgets/curved_navigation_bar/curved_navigation_bar.dart';

class TabsPageModel extends BaseModel {
  List<Widget> pages = [HomeView(), Container(), Container()];
  int selectedIndex = 0;
  CurvedNavigationBar bottomBar;

  bool completed = false;

  onModelReady(BuildContext context) async {}

  toFirstTab() {
    final CurvedNavigationBarState fState = bottomBarKey.currentState;
    if (fState.getCurrentIndex() != 0) {
      fState.buttonTap(0);
      notifyListeners();
    }
  }

  changeTabSelected(index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      // When you tap on a tab the page is added to the list of pages and loaded automatically
      switch (index) {
        case 1:
          pages[index] = Container();
          break;
        case 2:
          pages[index] = RegisterUserView();
          break;
        default:
      }
      notifyListeners();
    }
  }
}
