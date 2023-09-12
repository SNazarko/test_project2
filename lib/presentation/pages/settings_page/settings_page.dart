import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = '/settings_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('SettingsPage'),
      ),
    );
  }
}
