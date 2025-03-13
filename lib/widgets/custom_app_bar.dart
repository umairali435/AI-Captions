import 'package:aicaptions/res/app_colors.dart';
import 'package:aicaptions/widgets/icon_square.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData trailingIcon;
  final IconData leadingIcon;
  final String title;
  final VoidCallback onPressedTrailing;
  final VoidCallback onPressedLeading;
  final Color? trailingIconColor;
  final Color? leadingIconColor;
  final bool? showTrailingIcon;
  const CustomAppBar({
    super.key,
    required this.leadingIcon,
    required this.onPressedLeading,
    required this.onPressedTrailing,
    required this.title,
    required this.trailingIcon,
    this.trailingIconColor,
    this.showTrailingIcon,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconSquare(
              onTap: onPressedLeading,
              child: Icon(
                leadingIcon,
                color: leadingIconColor ?? AppColors.whiteColor,
                size: 16.0,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showTrailingIcon ?? true)
              IconSquare(
                onTap: onPressedTrailing,
                child: Icon(
                  trailingIcon,
                  color: trailingIconColor ?? AppColors.whiteColor,
                  size: 16.0,
                ),
              )
            else
              Row(
                children: [
                  SizedBox.shrink(
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
