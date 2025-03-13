import 'package:aicaptions/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  final double? margin;
  const CustomButton({
    super.key,
    this.height = 45.0,
    this.width = double.infinity,
    required this.label,
    required this.onTap,
    this.margin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(vertical: margin ?? 14.0, horizontal: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    color: AppColors.whiteColor,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 16.0,
                    color: AppColors.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
