import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);
  static const routeName = '/guide_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('GuidePage'),
      ),
    );
  }
}
