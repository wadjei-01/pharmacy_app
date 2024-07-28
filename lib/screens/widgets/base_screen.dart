import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:pharmacy_app/screens/widgets/outlined_square_button.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final void Function()? leadingOnTap;
  final Widget child;
  final List<Widget>? actions;
  final bool hasBottomDivider;
  final Widget? bottomNavBar;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool showLeading;
  const BaseScreen({
    super.key,
    this.title,
    required this.child,
    this.titleWidget,
    this.leadingOnTap,
    this.actions,
    this.hasBottomDivider = false,
    this.bottomNavBar,
    this.backgroundColor,
    this.showLeading = true,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: showLeading
            ? Center(
                child: OutlinedSquareButton(
                  icon: Icons.chevron_left_rounded,
                  diameter: 35.r,
                  onTap: leadingOnTap ??
                      () {
                        context.pop();
                      },
                ),
              )
            : null,
        leadingWidth: 75.w,
        centerTitle: centerTitle,
        title: Visibility(
          visible: titleWidget == null,
          replacement: titleWidget ?? const SizedBox(),
          child: Text(
            title ?? '',
            style: AppTypography.title.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        titleSpacing: 20.w,
        actions: actions,
        backgroundColor: backgroundColor,
        bottom: hasBottomDivider
            ? PreferredSize(
                preferredSize: Size.fromHeight(1.h),
                child: Divider(height: 1.sp),
              )
            : null,
      ),
      backgroundColor: backgroundColor ?? AppColors.backgroundColor,
      body: child,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
