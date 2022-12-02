import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/address_book_controller.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

import 'address_book_screen.dart';
import 'widgets/address_card_widgets.dart';

class AddressBookListScreen extends StatelessWidget {
  static const routeName = 'address_book_list_screen';

  final bool isCheckout;

  const AddressBookListScreen({
    Key? key,
    this.isCheckout = false,
  }) : super(key: key);

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<AddressBookController>().getAllAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Address'.tr),
      ),
      body: GetBuilder<AddressBookController>(
        builder: (addressController) {
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: addressController.addressList.isEmpty
                      ? const Center(
                          child: Text('No data address available'),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              kHeightBox10,
                              Container(
                                child: addressController.selectedItemAddress !=
                                        null
                                    ? InkWell(
                                        onTap: () {
                                          if (isCheckout) {
                                            addressController
                                                .selectedIsCheckoutAddress(
                                              addressController
                                                  .selectedItemAddress!,
                                            );
                                            Get.back();
                                          }
                                        },
                                        onLongPress: () {
                                          log('message');
                                          addressController.removeFromAddress(
                                              addressController
                                                      .selectedItemAddress
                                                      ?.id ??
                                                  0);
                                        },
                                        child: AddressCard(
                                          onEditTap: () {
                                            Get.to(
                                              () => AddressBookScreen(
                                                data: addressController
                                                    .selectedItemAddress!,
                                              ),
                                            );
                                          },
                                          data: addressController
                                              .selectedItemAddress!,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Container(
                                child: addressController.unSelectedList.isEmpty
                                    ? const SizedBox()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: addressController
                                            .unSelectedList.length,
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return InkWell(
                                              onTap: () {
                                                if (isCheckout) {
                                                  addressController
                                                      .selectedIsCheckoutAddress(
                                                    addressController
                                                        .unSelectedList[index],
                                                  );
                                                  Get.back();
                                                }
                                              },
                                              onLongPress: () {
                                                log('message');
                                                addressController
                                                    .removeFromAddress(
                                                        addressController
                                                                .unSelectedList[
                                                                    index]
                                                                .id ??
                                                            0);
                                              },
                                              child: AddressCard(
                                                onEditTap: () {
                                                  Get.to(
                                                    () => AddressBookScreen(
                                                      data: addressController
                                                              .unSelectedList[
                                                          index],
                                                    ),
                                                  );
                                                },
                                                data: addressController
                                                    .unSelectedList[index],
                                              ));
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DefaultBtn(
                          width: SizeConfig.screenWidth,
                          radius: 10.0,
                          title: 'Add New Address'.tr,
                          onPress: () {
                            Get.to(
                              () => const AddressBookScreen(
                                isNew: true,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
