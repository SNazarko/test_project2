import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.tabPage}) : super(key: key);
  final TabPageState tabPage;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: AppColors.blue,
      indicatorColor: AppColors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: AppColors.black,
      dividerColor: AppColors.white,
      padding: const EdgeInsets.all(0.0),
      controller: tabPage.controller,
      tabs: const [
        Tab(
          text: 'scan',
          icon: Icon(Icons.radar),
          iconMargin: EdgeInsets.all(0.0),
        ),
        Tab(
          text: 'bluetooth',
          icon: Icon(Icons.bluetooth),
          iconMargin: EdgeInsets.all(0.0),
        ),
        Tab(
          text: 'guide',
          icon: Icon(Icons.info_outline),
          iconMargin: EdgeInsets.all(0.0),
        ),
        Tab(
          text: 'settings',
          icon: Icon(Icons.settings),
          iconMargin: EdgeInsets.all(0.0),
        ),
      ],
    );
  }
}
