import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/controllers/recent_post_controller.dart';
import 'package:woogoods/view/widgets/custom_alert_dialog.dart';
import 'package:woogoods/view/widgets/product_grid_list.dart';

class RecentViewScreen extends StatelessWidget {
  static const routeName = 'recent_view_screen';

  const RecentViewScreen({Key? key}) : super(key: key);

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<RecentController>().getRecentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    final _scrollController = ScrollController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Recent Views'.tr),
          actions: [
            InkWell(
              onTap: () {
                CustomAlertDialog().customAlert2(
                  context: context,
                  title: 'Clear Form Recent'.tr,
                  body: 'Are you sure want to recent item'.tr,
                  color: kPrimaryColor,
                  confirmTitle: 'Clear'.tr,
                  onPress: () {
                    Get.find<RecentController>().emptyRecentView();
                  },
                );
              },
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  'Clear'.tr,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        ),
        body: GetBuilder<RecentController>(builder: (recentController) {
          return recentController.productList.isNotEmpty
              ? ProductGridList(
                  controller: _scrollController,
                  noPadding: false,
                  isCart: true,
                  reverse: false,
                  productList: recentController.productList,
                )
              : Center(
                  child: Text(
                    'No data available'.tr,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                );
        }));
  }
}
