import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/models/ticket_model.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

import 'create_ticket_screen.dart';
import 'widgets/ticket_list_card.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: ListView.builder(
                itemCount: ticketsList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => const CreateTicketScreen(),
                    ),
                    child: TicketListCard(
                      data: ticketsList[index],
                    ),
                  );
                }),
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
                      title: 'Create a new Ticket'.tr,
                      onPress: () {
                        Get.to(
                          () => const CreateTicketScreen(),
                          
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
