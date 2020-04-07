import 'package:flutter/material.dart';
import 'package:flutter_provider_firebase/pages/first_page.dart';
import 'package:flutter_provider_firebase/pages/profile_page.dart';
import 'package:flutter_provider_firebase/pages/second_page.dart';

class AppBottomNavBar extends ChangeNotifier {
  int _navIndex = 0;

  final _pages = List<Widget>.unmodifiable([
    FirstPage(),
    SecondPage(),
    ProfilePage(),
  ]);

  final _iconList = List<IconData>.unmodifiable([
    Icons.home,
    Icons.message,
    Icons.account_circle,
  ]);

  final _iconTitle = List<String>.unmodifiable([
    'Welcome',
    'Message',
    'Profile',
  ]);

  set navIndex(int i) {
    _navIndex = i;
    notifyListeners();
  }

  get navIndex => this._navIndex;
  get currentPage => this._pages[this._navIndex];
  get currentIcons => this._iconList;
  get currentTitles => this._iconTitle;
}
