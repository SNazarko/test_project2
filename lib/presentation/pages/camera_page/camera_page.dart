// ignore_for_file: deprecated_member_use

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_project/domain/enums/enums.dart';
import 'package:test_project/presentation/theme/app_colors.dart';
import 'package:test_project/presentation/theme/app_icons.dart';
import 'package:test_project/dependency_injection.dart' as di;

import '../../widgets/camera_buttons.dart';
import 'cubit/camera_cubit.dart' as cubit;

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);
  static const routeName = '/camera_page';

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final cubit.CameraCubit cameraCubit = di.getIt.get();
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;

  @override
  void initState() {
    _getCamera().then((value) {
      _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
      _cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              break;
            default:
              break;
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubit.CameraCubit, cubit.CameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
        if (state.status == BlocStatus.loaded) {
          return LayoutBuilder(builder: (context, boxConstraints) {
            return Scaffold(
              body: Stack(
                children: [
                  SizedBox(
                    width: boxConstraints.maxWidth,
                    height: boxConstraints.maxHeight,
                    child: _cameraController != null
                        ? CameraPreview(_cameraController!)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  if (state.color != null)
                    Positioned(
                        top: 0,
                        left: 0,
                        width: boxConstraints.maxWidth,
                        height: boxConstraints.maxHeight,
                        child: Container(
                          width: boxConstraints.maxWidth,
                          height: boxConstraints.maxHeight,
                          color: state.color,
                        )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 40.0,
                            ).copyWith(top: 40.0),
                            child: Text(
                              'Hidder cameras may heve infrared backlight and it usually looks like red dots',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 14.0),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CameraButtons(
                            cameraController: _cameraController,
                            cameras: _cameras,
                            onTap: (i) => cameraCubit
                                .changeColor(i),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          'Lens Detector',
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                        GestureDetector(
                          onTap: () => _onTapCameraDirection(),
                          child: SvgPicture.asset(
                            AppIcons.cameraRotate,
                            width: 30.0,
                            height: 30.0,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        } else if (state.status == BlocStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<void> _getCamera() async {
    _cameras = await availableCameras();
  }

  Future<void> _initCamera(camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    await _cameraController!.initialize();
    try {
      await _cameraController!.setFlashMode(FlashMode.off);
    } catch (_) {}
    setState(() {});
  }

  void _onTapCameraDirection() {
    if (_cameraController!.description.lensDirection ==
        CameraLensDirection.back) {
      _initCamera(
        _cameras[1],
      );
    } else {
      _initCamera(
        _cameras[0],
      );
    }
  }
}
