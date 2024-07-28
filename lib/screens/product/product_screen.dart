import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:pharmacy_app/data/model/product/product.dart';
import 'package:pharmacy_app/data/viewmodels/cart/cart_viewmodel.dart';
import 'package:pharmacy_app/screens/cart/cart_screen.dart';
import 'package:pharmacy_app/screens/home/components/product/product_container.dart';
import 'package:pharmacy_app/screens/widgets/outlined_square_button.dart';
import 'package:solar_icons/solar_icons.dart';

class ProductScreen extends HookConsumerWidget {
  final Map<String, dynamic> productDetails;
  const ProductScreen({super.key, required this.productDetails});
  static const id = '/product';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = useMemoized(() => productDetails['product']) as Product;
    final quantity = useState<int>(productDetails['quantity']);
    final cartViewModel = ref.watch(CartViewmodel.provider.notifier);
    final cartState = ref.watch(CartViewmodel.provider);

    return PopScope(
      onPopInvoked: (didPop) async {
        context.pop(quantity.value);
      },
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.innerContainerColor,
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          color: Colors.white,
          child: ElevatedButton(
              onPressed: () {
                if (!cartViewModel.addToCart(product, quantity.value)) {}
              },
              style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)))),
              child: Text(
                'Add to Cart',
                style: AppTypography.bodyOne
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Center(
                  child: OutlinedSquareButton(
                icon: Icons.chevron_left_rounded,
                diameter: 35.r,
                onTap: () => context.pop(quantity.value),
              )),
              backgroundColor: AppColors.innerContainerColor,
              actions: [
                Badge(
                  isLabelVisible: cartState.isNotEmpty,
                  child: OutlinedSquareButton(
                    icon: SolarIconsOutline.cart,
                    diameter: 35.r,
                    onTap: () => context.push(CartScreen.id),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 0.43.sh,
                ),
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.only(bottom: 10.h),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250.r,
                        width: 250.r,
                        child: Image.asset(
                          product.img,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: 12.w,
                        height: 4.h,
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.black),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 40.w),
                        child: Text(
                          product.productName,
                          style: AppTypography.headingOne
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        child: Text('500mg * 8 oz refill'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.only(top: 20.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.r))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantityButton(
                          quantity: quantity.value,
                          onTap: (value) => quantity.value = value,
                          buttonRadius: 17.r,
                          quantityPadding: 10.r,
                        ),
                        Text(
                          '\$ ${product.price.toStringAsFixed(2)}',
                          style: AppTypography.title
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ).paddingSymmetric(horizontal: 15.w),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Product Details",
                      style: AppTypography.headingOne
                          .copyWith(fontWeight: FontWeight.w500),
                    ).paddingSymmetric(horizontal: 10.w),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      product.description,
                    ).paddingSymmetric(horizontal: 10.w),
                    ExpansionTile(
                      title: Text(
                        'Reviews',
                        style: AppTypography.headingOne
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      tilePadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      shape: const RoundedRectangleBorder(),
                      trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                      children: [Text(product.description)],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
        // bottomNavigationBar: Container(
        //   height: kBottomNavigationBarHeight,
        //   width: double.infinity,
        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       border: Border(
        //           top: BorderSide(color: AppColors.containerOutlineColor))),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //
        //       QuantityButton(quantity: quantity)
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
