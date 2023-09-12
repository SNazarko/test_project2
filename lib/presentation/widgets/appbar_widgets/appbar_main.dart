// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';

import '../../pages/camera_page/camera_page.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget{
  const AppBarMain({Key? key, this.onTap}) : super(key: key);
 final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
      leading: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ).copyWith(left: 16.0),
        child: GestureDetector(
          onTap: ()async{
            Routemaster.of(context)
                .push(CameraPage.routeName,);
          },
          child: SvgPicture.asset(
            AppIcons.cameraSvgrepo,
            width: 35.0,
            height: 35.0,
            color: AppColors.white,
          ),
        ),
      ),
      title: Text(
        'Detection',
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ).copyWith(right: 16.0),
            child: SvgPicture.asset(AppIcons.back,
              width: 35.0,
              height: 35.0,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
