import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test_project/presentation/theme/app_colors.dart';
import 'package:test_project/presentation/widgets/custom_tabbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
        color: AppColors.grey,
        child: CustomTabBar(
          tabPage: tabPage,
        ),
      ),
      body: TabBarView(
        controller: tabPage.controller,
        children: [
          for (final stack in tabPage.stacks) PageStackNavigator(stack: stack),
        ],
      ),
    );
  }
}
