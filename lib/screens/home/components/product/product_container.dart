import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pharmacy_app/core/res/app_colors.dart';
import 'package:pharmacy_app/core/themes/text_theme.dart';
import 'package:pharmacy_app/data/model/product/product.dart';
import 'package:pharmacy_app/screens/product/product_screen.dart';

class ProductContainer extends HookWidget {
  final Product product;
  const ProductContainer({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = useState<int>(1);
    final hPadding = 5.w;

    return GestureDetector(
      onTap: () async {
        final result = await context.push(ProductScreen.id,
            extra: {'product': product, 'quantity': quantity.value});
        if (result != null) {
          quantity.value = result as int;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: AppColors.innerContainerColor,
                borderRadius: BorderRadius.circular(20.r)),
            child: Image.asset(
              product.img,
              width: 30.w,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            product.productName,
            style: AppTypography.bodyTwo.copyWith(fontWeight: FontWeight.w600),
            maxLines: 1,
          ).paddingSymmetric(vertical: 2.h, horizontal: hPadding),
          Text(
            product.description,
            style: AppTypography.xSmall.copyWith(height: 1.2),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ).paddingSymmetric(horizontal: hPadding),
          const Spacer(),
          Text(
            'Stock: ${product.stock}',
            style: AppTypography.xSmall.copyWith(fontWeight: FontWeight.bold),
          ).paddingSymmetric(horizontal: hPadding),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text: '\$ ',
                      style: AppTypography.small.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: product.price.toStringAsFixed(2),
                        style:
                            AppTypography.bodyTwo.copyWith(color: Colors.black))
                  ])),
              QuantityButton(
                  quantity: quantity.value,
                  onTap: (value) => quantity.value = value)
            ],
          ).paddingSymmetric(horizontal: hPadding)
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key,
      required this.quantity,
      required this.onTap,
      this.height,
      this.width,
      this.buttonRadius,
      this.quantityPadding});

  final int quantity;
  final void Function(int value) onTap;
  final double? width;
  final double? height;
  final double? buttonRadius;
  final double? quantityPadding;

  void decrement() {
    if (quantity > 1) onTap(quantity - 1);
  }

  void increment() {
    if (quantity < 50) onTap(quantity + 1);
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = buttonRadius != null ? buttonRadius! + 2.r : null;

    return Container(
      padding: EdgeInsets.all(5.r),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: AppColors.innerContainerColor,
          borderRadius: BorderRadius.circular(
              (buttonRadius != null ? buttonRadius! + 5 : 20.r))),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => decrement(),
            child: CircleAvatar(
              radius: buttonRadius ?? 15.r,
              backgroundColor: Colors.white,
              child: Icon(
                Iconsax.minus,
                color: AppColors.primaryColor,
                size: iconSize,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: AppTypography.bodyOne,
          ).paddingSymmetric(horizontal: quantityPadding ?? 5.w),
          GestureDetector(
            onTap: () => increment(),
            child: CircleAvatar(
              radius: buttonRadius ?? 15.r,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Iconsax.add,
                size: iconSize,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
