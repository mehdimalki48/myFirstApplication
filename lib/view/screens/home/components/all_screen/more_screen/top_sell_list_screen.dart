import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import 'package:woogoods/view/widgets/product_listview.dart';

class TopSellListScreen extends StatefulWidget {
  static const routeName = 'top_sell_list_screen';

  const TopSellListScreen({
    Key? key,
    this.dataList = 10,
  }) : super(key: key);
  final int dataList;

  @override
  State<TopSellListScreen> createState() => _TopSellListScreenState();
}

class _TopSellListScreenState extends State<TopSellListScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Top Sale'.tr,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            kWidthBox10,
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'in January',
                  style: kDescriptionText.copyWith(
                    color: kWhiteColor,
                  ),
                )),
          ],
        ),
        actions: const [
          AppBarActions(
            isMoreVert: true,
            isWishlist: true,
            isCart: true,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ProductListView(
          controller: _scrollController,
          noPadding: true,
          productLength: 20,
          cardColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
