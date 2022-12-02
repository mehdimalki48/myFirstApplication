import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/controllers/coupon_controller.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'widgets/coupon_card_widgets.dart';

class CouponListScreen extends StatelessWidget {
  static const routeName = 'coupon_list_screen';
  const CouponListScreen({
    Key? key,
    this.dataList = 10,
    this.couponStatus = false,
  }) : super(key: key);
  final int dataList;
  final bool couponStatus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CouponController>(builder: (couponController) {
        return couponStatus == false
            ? couponController.couponList.isNotEmpty
                ? ListView.builder(
                    itemCount: couponController.couponList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: CouponCardWidgets(
                          couponStatus: couponStatus,
                          index: index,
                          couponData: couponController.couponList[index],
                        ),
                      );
                    })
                : couponListShimmer()
            : couponController.useCouponList.isNotEmpty
                ? ListView.builder(
                    itemCount: couponController.useCouponList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: CouponCardWidgets(
                          couponStatus: couponStatus,
                          index: index,
                          couponData: couponController.useCouponList[index],
                        ),
                      );
                    })
                : const Center(
                    child: Text(
                      'no data available',
                    ),
                  );
      }),
    );
  }
}
