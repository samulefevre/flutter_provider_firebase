import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/providers/app_bottom_nav_bar.dart';
import 'package:flutter_provider_firebase/components/my_nav_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppBottomNavBar>(
      create: (context) => AppBottomNavBar(),
      child: Consumer<AppBottomNavBar>(
        builder: (context, appNavBar, _) => Scaffold(
          body: appNavBar.currentPage,
          bottomNavigationBar: MyNavBar(
            icons: appNavBar.currentIcons,
            titles: appNavBar.currentTitles,
            activeIndex: appNavBar.navIndex,
            onPressed: (i) {
              appNavBar.navIndex = i;
            },
          ),
        ),
      ),
    );
  }
}
