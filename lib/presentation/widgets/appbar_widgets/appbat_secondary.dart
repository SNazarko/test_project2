// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';

class AppBatSecondary extends StatelessWidget implements PreferredSizeWidget {
  const AppBatSecondary({Key? key, required this.title, this.iconInfo = true})
      : super(key: key);
  final String title;
  final bool? iconInfo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Routemaster.of(context).pop([true]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ).copyWith(left: 16.0),
          child: SvgPicture.asset(
            AppIcons.arrowLeft,
            width: 35.0,
            height: 35.0,
            color: AppColors.text,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: AppColors.text,
            ),
      ),
      actions: iconInfo!
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ).copyWith(right: 16.0),
                child: SvgPicture.asset(
                  AppIcons.info,
                  width: 35.0,
                  height: 35.0,
                  color: AppColors.text,
                ),
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
