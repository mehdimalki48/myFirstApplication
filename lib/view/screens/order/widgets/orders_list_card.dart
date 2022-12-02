import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/date_converter.dart';
import 'package:woogoods/models/response/order_list.dart';

class OrderListCard extends StatelessWidget {
  final bool orderStatusCheck;
  final bool paymentStatus;
  final String orderStatus;
  final OrderList orderList;

  const OrderListCard({
    Key? key,
    this.orderStatusCheck = false,
    this.paymentStatus = true,
    this.orderStatus = 'pending',
    required this.orderList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      width: SizeConfig.screenWidth,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1.0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 10),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onLongPress: () {
                        Clipboard.setData(
                          ClipboardData(text: orderList.id.toString()),
                        );
                        showCustomSnackBar('Order id copped', isError: false);
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          '#AI${orderList.id ?? 0}',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          kCurrency +
                              '${double.parse(
                                orderList.total.toString(),
                              ).toInt()}',
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 1.50,
                                    fontSize: 16.0,
                                  ),
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: orderStatusCheck == false
                            ? Container(
                                alignment: Alignment.topRight,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                        )),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: paymentStatus
                                                ? const Color(0xFF11922E)
                                                : kPaymentStatus,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          child: Text(
                                            orderList.status! == 'completed' ||
                                                    orderList.datePaid != null
                                                ? 'paid'
                                                : 'unpaid',
                                            textAlign: TextAlign.center,
                                            style: kDescriptionText.copyWith(
                                                color: kWhiteColor),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                alignment: Alignment.topRight,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: orderStatus == 'pending'
                                                ? const Color(0xFF363636)
                                                : const Color(0xFFBE20CD),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5)),
                                          ),
                                          child: Text(
                                            orderList.status ?? 'pending',
                                            textAlign: TextAlign.center,
                                            style: kDescriptionText.copyWith(
                                                color: kWhiteColor),
                                          ),
                                        )),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: paymentStatus
                                                ? const Color(0xFF11922E)
                                                : kPaymentStatus,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                          ),
                                          child: Text(
                                            orderList.status! == 'completed' ||
                                                    orderList.datePaid != null
                                                ? 'paid'
                                                : 'unpaid',
                                            textAlign: TextAlign.center,
                                            style: kDescriptionText.copyWith(
                                                color: kWhiteColor),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Container(
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            DateFormat('MMM dd, yyyy').format(
                                DateConverter.convertStringToDateFormat2(
                                    orderList.dateCreated!)),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: kStUnderLineColor2,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w300),
                          )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
