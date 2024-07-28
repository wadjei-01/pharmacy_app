import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:pharmacy_app/data/model/cart/cart_item.dart';
import 'package:pharmacy_app/data/viewmodels/cart/cart_viewmodel.dart';
import 'package:pharmacy_app/screens/home/components/product/product_container.dart';
import 'package:pharmacy_app/screens/widgets/base_screen.dart';
import 'package:pharmacy_app/screens/widgets/outlined_square_button.dart';
import 'package:solar_icons/solar_icons.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});
  static const id = '/cart';

  @override
  Widget build(BuildContext context, ref) {
    final cartState = ref.watch(CartViewmodel.provider);
    final cartViewModel = ref.watch(CartViewmodel.provider.notifier);
    return BaseScreen(
      title: 'Process Transaction',
      backgroundColor: Colors.white,
      centerTitle: true,
      bottomNavBar: CartBottomNavBar(subTotal: cartViewModel.subTotal),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 110.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(15.r)),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Prescription',
                style: AppTypography.headingOne,
              ),
              SizedBox(
                height: 7.h,
              ),
              const PrescriptionRow(
                label: 'Name',
                value: 'Amount',
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          )),
          SliverList.builder(
            itemCount: cartState.length,
            itemBuilder: (context, index) => PrescriptionRow(
              label: cartState[index].productName,
              value: 'x${cartState[index].quantity}',
              labelTextStyle: AppTypography.bodyTwo.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.bold),
              valueTextStyle: AppTypography.bodyTwo.copyWith(
                  color: AppColors.darkGreyColor, fontWeight: FontWeight.bold),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(5.r),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.lightGreyColor)),
                    child: Row(
                      children: [
                        Icon(
                          SolarIconsOutline.pen2,
                          size: 15.r,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Check Note',
                          style: AppTypography.bodyTwo
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Your Order  ',
                    children: [
                      TextSpan(
                          text: '${cartState.length} items',
                          style: AppTypography.bodyOne
                              .copyWith(color: AppColors.primaryColor))
                    ],
                    style: AppTypography.headingOne.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SliverList.builder(
            itemCount: cartState.length,
            itemBuilder: (context, index) {
              final top = index == 0 ? 10.r : 2.r;
              final bottom = index == cartState.length - 1 ? 10.r : 2.r;

              return CartContainer(
                cartItem: cartState[index],
                index: index,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(top), bottom: Radius.circular(bottom)),
              );
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}

class CartBottomNavBar extends HookConsumerWidget {
  final double subTotal;
  const CartBottomNavBar({
    required this.subTotal,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isExpanded = useState<bool>(true);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: AppColors.lightGreyColor.withOpacity(0.7),
            blurRadius: 15.r,
            spreadRadius: 5,
            offset: Offset(0, -15.h))
      ]),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Summary',
                  style: AppTypography.bodyOne
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                OutlinedSquareButton(
                  icon: isExpanded.value
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  diameter: 35.r,
                  onTap: () {
                    isExpanded.value = !isExpanded.value;
                  },
                )
              ],
            ),
            Divider(
              color: AppColors.lightGreyColor,
            ),
            CustomAnimatedFade(
                isExpanded: isExpanded.value,
                child: Column(
                  children: [
                    PrescriptionRow(
                        label: 'Subtotal',
                        value: '\$ ${subTotal.toStringAsFixed(2)}'),
                    SizedBox(
                      height: 5.h,
                    ),
                    const PrescriptionRow(
                        label: 'Platform fee', value: '\$3.00'),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrescriptionRow(
                      label: 'Total',
                      value: '\$ ${(subTotal + 3).toStringAsFixed(2)}',
                      labelTextStyle: AppTypography.bodyOne
                          .copyWith(fontWeight: FontWeight.bold),
                      valueTextStyle: AppTypography.bodyOne
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            SizedBox(
              height: 5.h,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Purchase Now',
                  style: AppTypography.bodyOne.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )).marginSymmetric(vertical: 10.h),
          ],
        ),
      ),
    );
  }
}

class PrescriptionRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;
  const PrescriptionRow({
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelTextStyle ??
              AppTypography.bodyTwo.copyWith(
                  color: AppColors.darkerGreyColor,
                  fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: valueTextStyle ??
              AppTypography.bodyTwo.copyWith(
                  color: AppColors.darkerGreyColor,
                  fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class CostRow extends StatelessWidget {
  const CostRow({
    super.key,
    required this.title,
    required this.cost,
  });

  final String title;
  final String cost;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.small,
        ),
        Text(
          cost,
          style: AppTypography.small.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    ).paddingOnly(bottom: 10.h);
  }
}

class CartContainer extends HookConsumerWidget {
  const CartContainer({
    super.key,
    required this.index,
    required this.cartItem,
    this.borderRadius,
  });

  final CartItem cartItem;
  final int index;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, ref) {
    final quantity = useState<int>(cartItem.quantity);
    final cartState = ref.read(CartViewmodel.provider.notifier);

    return Dismissible(
      key: Key('${cartItem.id}'),
      onDismissed: (direction) {
        cartState.deleteAt(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: EdgeInsets.symmetric(vertical: 2.5.h),
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.lightGreyColor),
            borderRadius: borderRadius ?? BorderRadius.circular(10.r)),
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                    height: 90.r,
                    width: 90.r,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.innerContainerColor),
                    child: Image.asset(cartItem.img)),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        cartItem.productName,
                        style: AppTypography.headingOne.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                        text: TextSpan(
                            text: '\$ ',
                            children: [
                              TextSpan(
                                  text: '${cartItem.price}',
                                  style: AppTypography.bodyOne.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                            style: AppTypography.bodyOne.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor)))
                  ],
                )
              ],
            ),
            QuantityButton(
              buttonRadius: 10.r,
              quantity: quantity.value,
              onTap: (value) {
                quantity.value = value;
                cartState.changeQuantity(cartItem, value, index);
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomAnimatedFade extends HookWidget {
  final bool isExpanded;
  final Widget child;
  const CustomAnimatedFade({
    required this.isExpanded,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 350),
    );

    final animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    useEffect(() {
      if (isExpanded) {
        controller.forward();
        return;
      }
      controller.reverse();
      return;
    });

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: FadeTransition(
              opacity: animation,
              child: SizeTransition(sizeFactor: animation, child: child)),
        ),
      ),
    );
  }
}
