import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:pharmacy_app/data/model/product/product.dart';
import 'package:pharmacy_app/data/viewmodels/cart/cart_viewmodel.dart';
import 'package:pharmacy_app/screens/cart/cart_screen.dart';
import 'package:pharmacy_app/screens/home/components/category_section.dart';
import 'package:pharmacy_app/screens/home/components/product/product_container.dart';
import 'package:pharmacy_app/screens/widgets/base_screen.dart';
import 'package:pharmacy_app/screens/widgets/outlined_square_button.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const id = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productProvider = ref.watch(productListProvider);
    final cartState = ref.watch(CartViewmodel.provider);

    return BaseScreen(
      showLeading: false,
      titleWidget: Row(
        children: [
          SvgPicture.asset(
            'assets/images/svg/medikitpos.svg',
            width: 30.r,
            height: 30.r,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            'MediKitPOS',
            style: AppTypography.bodyOne.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      actions: [
        OutlinedSquareButton(
          icon: SolarIconsOutline.ticket,
          diameter: 35.r,
        ),
        SizedBox(
          width: 10.w,
        ),
        OutlinedSquareButton(
          icon: SolarIconsOutline.bell,
          diameter: 35.r,
        ),
        SizedBox(
          width: 20.w,
        )
      ],
      bottomNavBar: const HomeBottomNavBar(),
      child: RefreshIndicator(
        onRefresh: () {
          ref.refresh(productListProvider);
          return Future.value(true);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.lightGreyColor, width: 1.sp),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Waitlist Number',
                              style: AppTypography.small.copyWith(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'A1',
                                  style: AppTypography.headingTwo.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                        text: '#12190',
                                        style: AppTypography.headingTwo
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                                    .withOpacity(0.2)))
                                  ]),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.scan,
                                size: 20.r,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Scan Again',
                                style: AppTypography.bodyTwo
                                    .copyWith(color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: AppColors.lightGreyColor,
                      thickness: 1.sp,
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Name',
                              style: AppTypography.small.copyWith(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'William Adjei',
                              style: AppTypography.headingOne.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                              text: '${cartState.length}',
                              style: AppTypography.headingOne.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: cartState.length > 1 ||
                                            cartState.isEmpty
                                        ? ' Items'
                                        : ' Item',
                                    style: AppTypography.headingOne.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black))
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 50.h,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                    color: AppColors.innerContainerColor,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Row(children: [
                  Icon(
                    Iconsax.search_normal_14,
                    color: AppColors.darkGreyColor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Search medicine...',
                    style: AppTypography.bodyTwo
                        .copyWith(color: AppColors.darkGreyColor),
                  )
                ]),
              ).paddingSymmetric(horizontal: 20.w),
            ),
            const CategorySection(),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Medicines',
                    style: AppTypography.bodyOne
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: AppTypography.small.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor),
                  ),
                ],
              ).marginSymmetric(horizontal: 20.w, vertical: 10.h),
            ),
            SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: productProvider.when(
                    data: (productList) {
                      return SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 10.h),
                        itemCount: productList.length,
                        itemBuilder: (context, index) => ProductContainer(
                          product: productList[index],
                        ),
                      );
                    },
                    error: (error, stackTrace) => SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.warning_2,
                                size: 70.r,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  'Sorry! unable to retrieve data at this moment',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.headingTwo
                                      .copyWith(fontWeight: FontWeight.w500)
                                      .copyWith(color: AppColors.darkGreyColor),
                                ),
                              )
                            ],
                          ),
                        ),
                    loading: () => SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ))),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kBottomNavigationBarHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBottomNavBar extends HookConsumerWidget {
  const HomeBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final cartState = ref.watch(CartViewmodel.provider);
    final cartViewModel = ref.watch(CartViewmodel.provider.notifier);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppColors.lightGreyColor,
          blurRadius: 3,
          spreadRadius: 1,
        )
      ], color: Colors.white),
      width: double.infinity,
      child: IntrinsicHeight(
          child: CustomAnimatedFade(
              isExpanded: !cartViewModel.isCartEmpty(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You\'ve added',
                          style: AppTypography.small
                              .copyWith(color: AppColors.darkGreyColor),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        RichText(
                          text: TextSpan(
                              text: '${cartState.length}',
                              style: AppTypography.bodyOne.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: ' Items',
                                    style: AppTypography.bodyOne
                                        .copyWith(color: Colors.black))
                              ]),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 25.w, vertical: 15.h))),
                        child: Text(
                          'Purchase \$ ${cartViewModel.subTotal.toStringAsFixed(2)}',
                          style: AppTypography.bodyOne.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ))),
    );
  }
}
