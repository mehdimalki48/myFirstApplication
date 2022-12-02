import 'package:flutter/material.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/ticket_model.dart';

class TicketListCard extends StatelessWidget {
  const TicketListCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Ticket data;

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
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#Ticket ${data.id.toString()}',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: kPrimaryColor,
                            fontSize: 16.0,
                          ),
                    ),
                    kHeightBox10,
                    Text(
                      data.ticketStatus,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: kStUnderLineColor,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Text(
                        data.date,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: kStUnderLineColor,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w300),
                      ),
                      kHeightBox10,
                      Container(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: data.status == 'Pending'
                                  ? const Color(0xFF363636):
                              data.status == 'Close' ? kErrorColor : kDeliveredColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              data.status,
                              textAlign: TextAlign.center,
                              style:
                                  kDescriptionText.copyWith(color: kWhiteColor),
                            ),
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
