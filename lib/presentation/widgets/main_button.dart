
import 'package:flutter/material.dart';
import 'package:test_project/presentation/theme/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.border,
    this.backgroundColor,
    this.setSecondColors,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final BoxBorder? border;
  final Color? backgroundColor;
  final bool? setSecondColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor ??
                (setSecondColors == true
                    ? AppColors.white
                    : AppColors.blue),
            border: border ??
                Border.all(
                  width: 2,
                  color: setSecondColors == true?  AppColors.buttonBorder2 : AppColors.buttonBorder1,
                ),
          ),
          child: Center(
            child: Text(
              text,
              style: setSecondColors == true
                ? Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textGrey,
              )
                : Theme.of(context).textTheme.labelLarge,

            ),
          ),
        ),
      ),
    );
  }
}
