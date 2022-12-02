import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors_data.dart';
import '../../../constants/style_data.dart';
import '../../../controllers/notifications_controller.dart';
import '../../widgets/custom_bottom_loader.dart';
import '../../widgets/custom_shimmer.dart';
import 'widgets/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = 'notification_screen';
  const NotificationScreen({Key? key}) : super(key: key);

  Future<void> _loadData(bool reload) async {
    Get.find<NotificationsController>().setOffset(1);
    Get.find<NotificationsController>()
        .getNotificationList('1', reload, );
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    final ScrollController scrollController = ScrollController();
    //load getX controller
    //_loadData(false);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          !Get.find<NotificationsController>().isLoading) {
        int pageSize = Get.find<NotificationsController>().popularPageSize;
        if (Get.find<NotificationsController>().notificationList.length < pageSize) {
          Get.find<NotificationsController>()
              .setOffset(Get.find<NotificationsController>().offset + 1);
          log('end page');
          Get.find<NotificationsController>().showBottomLoader();
          Get.find<NotificationsController>().getNotificationList(
              Get.find<NotificationsController>().offset.toString(), false,);
        }else{
          showCustomSnackBar('No more notifications');
        }
      }
    });
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: Text('Notification'.tr),
      ),
      body: GetBuilder<NotificationsController>(
        builder: (notificationsController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        child: notificationsController.isShimmerLoading
                            ? buildCommentListShimmer()
                            : notificationsController.notificationList.isNotEmpty
                            ? SingleChildScrollView(
                          controller: scrollController,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notificationsController.notificationList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, int index) {
                              return NotificationWidget(
                                title: notificationsController.notificationList[index].headings?.en ?? '',
                                subTitle: notificationsController.notificationList[index].contents?.en ?? '',
                                image: notificationsController.notificationList[index].chromeWebIcon ?? '',
                                onPress: () {
                                //  Get.to(() => const NewsDetailsScreen());
                                },
                              );
                            },
                          ),
                        )
                            : Center(
                          child: Text(
                            'No notifications available',
                            style: kRegularText2,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomBottomLoader(
                            isLoading: notificationsController.isLoading),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
