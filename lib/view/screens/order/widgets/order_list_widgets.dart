import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/controllers/orders_controller.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

import '../orders_details_screen.dart';
import 'orders_list_card.dart';

class OrderListWidgets extends StatefulWidget {
  final bool orderStatusCheck;
  final bool paymentStatus;
  final String orderStatus;

  const OrderListWidgets({
    Key? key,
    this.orderStatusCheck = false,
    this.paymentStatus = true,
    this.orderStatus = 'any',
  }) : super(key: key);

  @override
  State<OrderListWidgets> createState() => _OrderListWidgetsState();
}

class _OrderListWidgetsState extends State<OrderListWidgets> {
  final OrdersController orderController = Get.find();
  final _scrollController = ScrollController();

  @override
  void initState() {
    getProducts();
    _scrollController.addListener(addProducts);
    super.initState();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await orderController.fetchOrdersListData(
          orderController.offset.toString(), reload,
          status: widget.orderStatus);
    });
  }

  void addProducts() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('===========>>>work');
      orderController.changeOffset();
      orderController.showBottomLoader();
      getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: kPrimaryColor,
        backgroundColor: Theme.of(context).cardColor,
        displacement: 0,
        onRefresh: () async {
          orderController.isLoading(true);
          getProducts();
        },
        child: Obx(
          () {
            if (orderController.isLoading.isTrue) {
              return buildOrderListShimmer(
                  orderStatusCheck: widget.orderStatusCheck);
            } else {
              if (orderController.ordersList.isEmpty) {
                return const Center(
                  child: Text('No orders Available'),
                );
              } else {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      child: ListView.builder(
                        itemCount: orderController.ordersList.length,
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              int statusInx = 0;
                              bool isOrder = false;
                              String status =
                                  orderController.ordersList[index].status ??
                                      '';
                              if (status == 'pending') {
                                statusInx = 0;
                              } else if (status == 'on-hold') {
                                statusInx = 1;
                              } else if (status == 'processing') {
                                statusInx = 2;
                              } else if (status == 'completed') {
                                statusInx = 4;
                              } else if (status == 'cancelled') {
                                statusInx = 4;
                              } else if (status == 'refunded') {
                                statusInx = 5;
                              } else if (status == 'failed') {
                                statusInx = 4;
                              }

                              //check order status cancel return and failed
                              if (status == 'cancelled' ||
                                  status == 'refunded' ||
                                  status == 'failed') {
                                isOrder = false;
                              } else {
                                isOrder = true;
                              }
                              Get.to(
                                () => OrderDetailsScreen(
                                  processIndex: statusInx,
                                  isCanceled:
                                      status == 'cancelled' ? true : false,
                                  isReturned:
                                      status == 'refunded' ? true : false,
                                  isFailed: status == 'failed' ? true : false,
                                  isOrder: isOrder,
                                  orderList: orderController.ordersList[index],
                                ),
                                
                              );
                            },
                            child: OrderListCard(
                              orderStatusCheck: widget.orderStatusCheck,
                              paymentStatus: widget.paymentStatus,
                              orderStatus: widget.orderStatus,
                              orderList: orderController.ordersList[index],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: orderController.isLoadingMore.isTrue
                          ? const Center(child: CustomLoader())
                          : const SizedBox(),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
