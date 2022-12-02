import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/date_converter.dart';
import 'package:woogoods/models/response/coupon_list_rp.dart';
import 'package:woogoods/view/widgets/text_btn.dart';
import '../../../../../../main.dart';

class CouponCardWidgets extends StatelessWidget {
  final CouponListRp couponData;
  final bool couponStatus;
  final int index;

  const CouponCardWidgets({
    Key? key,
    this.couponStatus = false,
    required this.index,
    required this.couponData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: getProportionateScreenHeight(90),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [
                      kPrimaryColor,
                      kSecondaryColor,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: 5,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9E73),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(.20),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: const Offset(1, 2),
                              ),
                            ],
                          ),
                          height: 16,
                          child: Center(
                            child: Text(
                              couponData.code ?? '',
                              style: kSmallText.copyWith(
                                color: kWhiteColor,
                                fontSize: 8.0,
                                height: 1.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )),
                    Center(
                      child: Text(
                        '$kCurrency${double.parse(
                          couponData.amount.toString(),
                        ).toInt()}',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(couponData.description ?? '',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline1),
                      kHeightBox5,
                      Text(
                        '${DateFormat('MMM dd, yyyy').format(DateConverter.convertStringToDateFormat2(couponData.dateCreated!))} - ${getExpiredDate()}',
                        style: kSmallText.copyWith(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      kHeightBox5,
                      Text(
                        'Usage count: ${couponData.usageCount ?? 0}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: couponStatus
                    ? (SizeConfig.screenWidth! - 70) / 3
                    : (SizeConfig.screenWidth! - 100) / 3,
                padding: EdgeInsets.only(right: couponStatus ? 0 : 5),
                child: Container(
                  child: couponStatus
                      ? InkWell(
                          onTap: () {
                            if ('Try use'.tr == getUseCheck()) {
                              Clipboard.setData(
                                ClipboardData(text: couponData.code ?? ''),
                              );
                              showCustomSnackBar('Coupon copped!',
                                  isError: false);
                            } else {
                              showCustomSnackBar(
                                "Don't Use!",
                              );
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DottedLine(
                                direction: Axis.vertical,
                                lineLength: getProportionateScreenHeight(90),
                                dashColor: kPrimaryColor,
                              ),
                              SizedBox(
                                width: (SizeConfig.screenWidth! - 90) / 3,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Text(
                                      getUseCheck(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: kPrimaryColor,
                                              fontSize: 12.0,
                                              height: 1.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : TextButtons(
                          radius: 5.0,
                          btnColor: const Color(0xFFFF9E73),
                          btnColor2: const Color(0xFFFF9E73),
                          onPress: () {
                            Clipboard.setData(
                              ClipboardData(text: couponData.code ?? ''),
                            );
                            showCustomSnackBar('Coupon copped!',
                                isError: false);
                          },
                          title: 'Get Now'.tr,
                        ),
                ),
              ),
            ],
          ),
        ),
        kHeightBox10,
      ],
    );
  }

  String getExpiredDate() {
    String data = '';
    data = couponData.dateExpires == null
        ? 'Unlimited'
        : DateFormat('MMM dd, yyyy').format(
            DateConverter.convertStringToDateFormat2(couponData.dateExpires!));
    return data;
  }

  int getUserUseCount() {
    int count = 0;
    if (couponData.usedBy!.isNotEmpty) {
      count = 0;
      for (int i = 0; i < couponData.usedBy!.length; i++) {
        var isExist = couponData.usedBy!.indexWhere(
            (element) => element == (prefs.getString(userId) ?? ""));

        if (isExist >= 0) {
          ++count;
        }
      }
      return count;
    } else {
      return 0;
    }
  }

  String getUseCheck() {
    String data = '';
    data = couponData.usageLimitPerUser == null
        ? 'Try use'.tr
        : couponData.usageLimitPerUser! > getUserUseCount()
            ? 'Try use'.tr
            : 'To use'.tr;
    return data;
  }
}
