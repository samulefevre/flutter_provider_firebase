import 'package:flutter/material.dart';

class MyNavBar extends StatefulWidget {
  final String name;

  final List<IconData> icons;
  final List<String> titles;
  final int activeIndex;
  final Function(int) onPressed;

  MyNavBar({
    this.name,
    @required this.icons,
    @required this.titles,
    @required this.activeIndex,
    @required this.onPressed,
  }) : assert(icons != null);

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        for (var i = 0; i < widget.icons.length; i++)
          BottomNavigationBarItem(
            icon: Icon(widget.icons[i]),
            title: Text(widget.titles[i]),
          )
      ],
      currentIndex: widget.activeIndex,
      onTap: widget.onPressed,
      //selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
