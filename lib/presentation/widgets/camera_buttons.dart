
// ignore_for_file: deprecated_member_use

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_icons.dart';

class CameraButtons extends StatefulWidget {
  CameraButtons(
      {Key? key, required this.cameraController, required this.cameras, this.onTap})
      : super(key: key);
  late CameraController? cameraController;
  final List<CameraDescription> cameras;
  final void Function(int i)? onTap;

  static const List<_CameraButtonsItem> _items = [
    _CameraButtonsItem(
      color: AppColors.red,
    ),
    _CameraButtonsItem(
      color: AppColors.green,
    ),
    _CameraButtonsItem(
      color: AppColors.yellow,
    ),
    _CameraButtonsItem(
      color: AppColors.text,
    ),
  ];

  @override
  State<CameraButtons> createState() => _CameraButtonsState();
}

class _CameraButtonsState extends State<CameraButtons> {
  int? _index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: CameraButtons._items.map((e) {
          final int i = CameraButtons._items.indexOf(e);
          return GestureDetector(
            onTap: () {
              setState(() {
                _index = i;
              });
              widget.onTap!(i);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10.0,
                ),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: _index == i ? AppColors.blue : AppColors.white,
                      )),
                  child: SvgPicture.asset(
                    AppIcons.cameraShutter,
                    color: e.color,
                  ),
                )),
          );
        }).toList(),
      ),
    );
  }
}

final class _CameraButtonsItem {
const _CameraButtonsItem({
required this.color,
});
final Color color;
}
