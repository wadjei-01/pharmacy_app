import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_app/core/app_constants.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:collection/collection.dart';

class CategorySection extends HookWidget {
  const CategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);
    final categoryList = AppConstants.categoryList;

    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoryList.mapIndexed((idx, category) {
            final leftMargin = idx == 0 ? 20.w : 2.5.w;
            final rightMargin = idx == categoryList.length - 1 ? 20.w : 2.5.w;

            final isSelected = idx == currentIndex.value;

            return GestureDetector(
              onTap: () {
                currentIndex.value = idx;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                margin: EdgeInsets.only(
                    left: leftMargin, right: rightMargin, bottom: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                decoration: BoxDecoration(
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.lightGreyColor,
                          ),
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  category,
                  style: AppTypography.small.copyWith(
                      color:
                          isSelected ? Colors.white : AppColors.darkGreyColor,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
