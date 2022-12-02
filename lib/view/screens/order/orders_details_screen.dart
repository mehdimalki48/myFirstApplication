import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/date_converter.dart';
import 'package:woogoods/models/response/order_list.dart';
import 'widgets/orders_product_card_widgets.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = 'orders_details_screen';

  final int processIndex;
  final OrderList orderList;
  final bool isOrder;
  final bool isCanceled;
  final bool isReturned;
  final bool isFailed;
  final bool isTracking;

  const OrderDetailsScreen({
    Key? key,
    required this.orderList,
    this.processIndex = 0,
    this.isOrder = true,
    this.isCanceled = false,
    this.isReturned = false,
    this.isFailed = false,
    this.isTracking = false,
  }) : super(key: key);

  Color getColor(int index) {
    if (index == processIndex) {
      return inProgressColor;
    } else if (index < processIndex) {
      return completeColor;
    } else {
      return kStUnderLineColor2;
    }
  }

  @override
  Widget build(BuildContext context) {
    List processes = [];
    if (isCanceled) {
      processes = ['Pending'.tr, 'On Hold'.tr, 'Processing'.tr, 'Canceled'.tr];
    } else if (isReturned) {
      processes = [
        'Pending'.tr,
        'On Hold'.tr,
        'Processing'.tr,
        'Delivered'.tr,
        'Returned'.tr
      ];
    } else if (isFailed) {
      processes = ['Pending'.tr, 'On Hold'.tr, 'Processing'.tr, 'Failed'.tr];
    } else {
      processes = ['Pending'.tr, 'On Hold'.tr, 'Processing'.tr, 'Delivered'.tr];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isTracking ? 'Order Tracking'.tr : 'Order Details'.tr),
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Invoice'.tr,
                                      style: Theme.of(context).textTheme.headline1?.copyWith(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' #AI${orderList.id ?? 0}',
                                      style: kRegularText2.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  DateFormat('MMM dd, yyyy').format(
                                      DateConverter.convertStringToDateFormat2(
                                          orderList.dateCreated!)),
                                  textAlign: TextAlign.end,
                                  style: kRegularText2.copyWith(
                                      color: kStUnderLineColor2,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          kHeightBox20,
                          if (isOrder || isCanceled || isFailed)
                            Container(
                              alignment: Alignment.center,
                              color: Theme.of(context).cardColor,
                              width: SizeConfig.screenWidth,
                              height: 90,
                              child: Align(
                                alignment: Alignment.center,
                                child: Timeline.tileBuilder(
                                  padding: EdgeInsets.zero,
                                  physics: const ScrollPhysics(),
                                  theme: TimelineThemeData(
                                    direction: Axis.horizontal,
                                    connectorTheme: const ConnectorThemeData(
                                      space: 30.0,
                                      thickness: 2.0,
                                    ),
                                  ),
                                  builder: TimelineTileBuilder.connected(
                                    connectionDirection:
                                        ConnectionDirection.before,
                                    itemExtentBuilder: (_, __) =>
                                        SizeConfig.screenWidth! / 4.5,
                                    contentsBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 13.0),
                                        child: Text(
                                          processes[index],
                                          style: kRegularText2.copyWith(
                                            color: kStUnderLineColor2,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      );
                                    },
                                    indicatorBuilder: (_, index) {
                                      Color color;
                                      dynamic child;
                                      if (index == processIndex) {
                                        color = Theme.of(context).cardColor;
                                        child = const Center(
                                          child: Icon(
                                            Icons.album_outlined,
                                            size: 20,
                                            color: completeColor,
                                          ),
                                        );
                                      } else if (index < processIndex) {
                                        color = completeColor;
                                        child = const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15.0,
                                        );
                                      } else {
                                        color = kStUnderLineColor2;
                                      }

                                      if (index <= processIndex) {
                                        return Stack(
                                          children: [
                                            CustomPaint(
                                              size: const Size(15.0, 15.0),
                                              painter: _BezierPainter(
                                                color: color,
                                                drawStart: index > 0,
                                                drawEnd: index < processIndex,
                                              ),
                                            ),
                                            DotIndicator(
                                              size: 20.0,
                                              color: color,
                                              child: child,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Stack(
                                          children: [
                                            CustomPaint(
                                              size: const Size(15.0, 15.0),
                                              painter: _BezierPainter(
                                                color: color,
                                                drawEnd: index <
                                                    processes.length - 1,
                                              ),
                                            ),
                                            OutlinedDotIndicator(
                                              borderWidth: 2.0,
                                              color: color,
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                    connectorBuilder: (_, index, type) {
                                      if (index > 0) {
                                        if (index == processIndex) {
                                          return const DecoratedLineConnector(
                                            decoration: BoxDecoration(
                                              color: completeColor,
                                            ),
                                          );
                                        } else {
                                          return SolidLineConnector(
                                            color: getColor(index),
                                          );
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    itemCount: processes.length,
                                  ),
                                ),
                              ),
                            ),
                          if (isReturned)
                            Container(
                              alignment: Alignment.center,
                              color: Theme.of(context).cardColor,
                              width: SizeConfig.screenWidth,
                              height: 90,
                              child: Align(
                                alignment: Alignment.center,
                                child: Timeline.tileBuilder(
                                  padding: EdgeInsets.zero,
                                  physics: const ScrollPhysics(),
                                  theme: TimelineThemeData(
                                    direction: Axis.horizontal,
                                    connectorTheme: const ConnectorThemeData(
                                      space: 30.0,
                                      thickness: 2.0,
                                    ),
                                  ),
                                  builder: TimelineTileBuilder.connected(
                                    connectionDirection:
                                        ConnectionDirection.before,
                                    itemExtentBuilder: (_, __) =>
                                        SizeConfig.screenWidth! / 5.6,
                                    contentsBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 13.0),
                                        child: Text(
                                          processes[index],
                                          style: kRegularText2.copyWith(
                                            color: kStUnderLineColor2,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      );
                                    },
                                    indicatorBuilder: (_, index) {
                                      Color color;
                                      dynamic child;
                                      if (index == processIndex) {
                                        color = Theme.of(context).cardColor;
                                        child = const Center(
                                          child: Icon(
                                            Icons.album_outlined,
                                            size: 20,
                                            color: completeColor,
                                          ),
                                        );
                                      } else if (index < processIndex) {
                                        color = completeColor;
                                        child = const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15.0,
                                        );
                                      } else {
                                        color = kStUnderLineColor2;
                                      }

                                      if (index <= processIndex) {
                                        return Stack(
                                          children: [
                                            CustomPaint(
                                              size: const Size(15.0, 15.0),
                                              painter: _BezierPainter(
                                                color: color,
                                                drawStart: index > 0,
                                                drawEnd: index < processIndex,
                                              ),
                                            ),
                                            DotIndicator(
                                              size: 20.0,
                                              color: color,
                                              child: child,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Stack(
                                          children: [
                                            CustomPaint(
                                              size: const Size(15.0, 15.0),
                                              painter: _BezierPainter(
                                                color: color,
                                                drawEnd: index <
                                                    processes.length - 1,
                                              ),
                                            ),
                                            OutlinedDotIndicator(
                                              borderWidth: 2.0,
                                              color: color,
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                    connectorBuilder: (_, index, type) {
                                      if (index > 0) {
                                        if (index == processIndex) {
                                          return const DecoratedLineConnector(
                                            decoration: BoxDecoration(
                                              color: completeColor,
                                            ),
                                          );
                                        } else {
                                          return SolidLineConnector(
                                            color: getColor(index),
                                          );
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    itemCount: processes.length,
                                  ),
                                ),
                              ),
                            ),
                          /*            size20,
                          Text(
                            'ORDER TIMELINE'.tr,
                            style: kRegularText2.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            ),
                          ),
                          size20,
                          SizedBox(
                              width: SizeConfig.screenWidth,
                              child: const OrderTimeline()),*/
                        ],
                      ),
                    ),
                  ),
                ),
                kHeightBox10,
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bill & ship to'.tr,
                            style: kRegularText2.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHeightBox10,
                          Text(
                            orderList.billing?.firstName ?? '',
                            style: kRegularText2.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            orderList.billing?.phone ?? '',
                            style: kRegularText2.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          kHeightBox5,
                          Text(
                            '${orderList.billing?.country ?? ''}, ${orderList.billing?.state ?? ''}, ${orderList.billing?.city ?? ''}, ${orderList.billing?.address1 ?? ''}',
                            style: kSmallText.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          kHeightBox5,
                        ],
                      ),
                    ),
                  ),
                ),
                kHeightBox10,
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary'.tr,
                            style: kRegularText2.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          kHeightBox10,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Sub Total:'.tr,
                                  style: kSmallText.copyWith(
                                    color: Get.isDarkMode
                                        ? kWhiteColor
                                        : kBlackColor2,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                kCurrency +
                                    '${double.parse(
                                      orderList.total.toString(),
                                    ).toInt()}',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                            ],
                          ),
                          kHeightBox10,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Shipping Fee:'.tr,
                                  style: kSmallText.copyWith(
                                    color: Get.isDarkMode
                                        ? kWhiteColor
                                        : kBlackColor2,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                kCurrency +
                                    '${double.parse(
                                      orderList.shippingTotal.toString(),
                                    ).toInt()}',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                            ],
                          ),
                          kHeightBox10,
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Voucher Discount:'.tr,
                                  style: kSmallText.copyWith(
                                    color: Get.isDarkMode
                                        ? kWhiteColor
                                        : kBlackColor2,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                '- $kCurrency${double.parse(
                                  orderList.discountTotal.toString(),
                                ).toInt()}',
                                style: kRegularText2.copyWith(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                          kHeightBox5,
                          Container(
                            height: .3,
                            color: kStUnderLineColor,
                          ),
                          kHeightBox5,
                          Container(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Total: '.tr,
                                    style: Theme.of(context).textTheme.headline2?.copyWith(
                                    ),
                                  ),
                                  TextSpan(
                                    text: kCurrency +
                                        '${double.parse(
                                          orderList.total.toString(),
                                        ).toInt()}',
                                    style: kRegularText2.copyWith(
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          kHeightBox5,
                        ],
                      ),
                    ),
                  ),
                ),
                kHeightBox10,
                Container(
                  child: orderList.lineItems!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderList.lineItems!.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, int index) {
                            return ProductCardWidgets(
                              product: orderList.lineItems![index],
                            );
                          },
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    dynamic angle;
    dynamic offset1;
    dynamic offset2;

    dynamic path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
