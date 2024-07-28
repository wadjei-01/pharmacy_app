import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';

class OutlinedSquareButton extends StatelessWidget {
  final IconData icon;
  final double diameter;
  final void Function()? onTap;
  const OutlinedSquareButton({
    required this.icon,
    this.diameter = 30,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGreyColor, width: 1.5.sp),
            borderRadius: BorderRadius.circular((diameter / 2.5) - 4)),
        child: Icon(
          icon,
          size: diameter / 2,
        ),
      ),
    );
  }
}
