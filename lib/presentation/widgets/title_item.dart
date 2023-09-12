// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_icons.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String text;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(250, 100)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppIcons.shieldCheck,
              width: 35.0,
              height: 35.0,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontSize: 16.0,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
