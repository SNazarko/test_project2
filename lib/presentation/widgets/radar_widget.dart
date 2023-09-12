// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/presentation/theme/app_fonts.dart';

import 'dart:math' as math;
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../utils/constants.dart';

class RadarWidget extends StatefulWidget {
  final double angle;
  final bool? isBlue;

  const RadarWidget({super.key, required this.angle, this.isBlue});

  @override
  State<RadarWidget> createState() => _RadarWidgetState();
}

class _RadarWidgetState extends State<RadarWidget> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height -
        (kToolbarHeight +
            kHeightScanPanel +
            kToolbarHeight +
            (widget.isBlue == true ? 110.0 : 50));
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: height,
            height: height,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(height / 16.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueShape500,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height / 5.4),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueShape300,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height / 3.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.blueShape100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: height / 5.5,
                  left: height / 5.5,
                  child: AnimatedOpacity(
                    opacity: widget.angle > 4.0 && widget.angle < 5.0 ? 1 : 0,
                    duration: Duration(
                      milliseconds:
                          widget.angle > 4.0 && widget.angle < 5.0 ? 1 : 3000,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.cameraShutter,
                      color: AppColors.white,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                Positioned(
                  top: height / 3,
                  left: height / 3,
                  child: AnimatedOpacity(
                    opacity: widget.angle > 4.0 && widget.angle < 5.0 ? 1 : 0,
                    duration: Duration(
                      milliseconds:
                          widget.angle > 4.0 && widget.angle < 5.0 ? 1 : 3000,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.eye,
                      color: AppColors.white,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                Positioned(
                  left: height / 5.61,
                  bottom: height / 3.93,
                  child: AnimatedOpacity(
                    opacity: widget.angle > 2.2 && widget.angle < 3.2 ? 1 : 0,
                    duration: Duration(
                      milliseconds:
                          widget.angle > 2.2 && widget.angle < 3.2 ? 1 : 3000,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.cameraVideo,
                      color: AppColors.white,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                Positioned(
                  top: height / 6.55,
                  right: height / 3.93,
                  child: AnimatedOpacity(
                    opacity: widget.angle > 5.0 && widget.angle < 6.0 ? 1 : 0,
                    duration: Duration(
                      milliseconds:
                          widget.angle > 5.0 && widget.angle < 6.0 ? 1 : 3000,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.cameraWeb,
                      color: AppColors.white,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                Positioned(
                  right: height / 4.91,
                  bottom: height / 4.91,
                  child: AnimatedOpacity(
                    opacity: widget.angle > 0.5 && widget.angle < 1.5 ? 1 : 0,
                    duration: Duration(
                      milliseconds:
                          widget.angle > 0.5 && widget.angle < 1.5 ? 1 : 3000,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.cameraSvgrepo2,
                      color: AppColors.white,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomPaint(
                      painter: _RadarPainter(
                        angle: widget.angle,
                        heightCont: height - 15.0,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: widget.isBlue == true
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(
                              AppIcons.bluetooth,
                              color: AppColors.blue,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
        if(widget.isBlue == true)
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Text('Move to find more devices',
          style:  Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
            fontSize: 18.0,
            fontWeight: AppFonts.regular,

          ),),
        ),
      ],
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double angle;
  final double heightCont;

  _RadarPainter({required this.angle, required this.heightCont});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = heightCont / 2;
    final centerY = heightCont / 2;
    final radius = heightCont / 0.9;

    final center = Offset(centerX, centerY);

    final radarPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, radarPaint);

    final handPaint = Paint()
      ..color = AppColors.red
      ..strokeWidth = 6
      ..style = PaintingStyle.fill;

    final handLength = radius * 0.40;
    final handX = centerX + handLength * math.cos(angle);
    final handY = centerY + handLength * math.sin(angle);

    canvas.drawLine(center, Offset(handX, handY), handPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
