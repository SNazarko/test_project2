// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_fonts.dart';

class Term extends StatelessWidget {
  const Term(
      {Key? key,
        required this.text1,
        required this.text2,
        required this.icon,
        this.onTap,
        this.iconColors,
        this.size})
      : super(key: key);
  final String text1;
  final String text2;
  final String icon;
  final Color? iconColors;
  final double? size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            text2,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: AppFonts.extraBold,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SvgPicture.asset(
                icon,
                color: iconColors,
                width: size ?? 20.0,
                height: size ?? 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}