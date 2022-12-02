import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:woogoods/constants/colors_data.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Pending',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          isFast: true,
          context: context,
        ),
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Confirmed',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          context: context,
        ),
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Processing',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          context: context,
        ),
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Picked',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          context: context,
        ),
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Shipped',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          context: context,
        ),
        _buildTimelineTile(
          indicator: const _IconIndicator(
            size: 20,
          ),
          hour: '31 Nov 12:00 AM',
          title: 'Delivered',
          desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          isLast: true,
          context: context,
        ),
      ],
    );
  }


  TimelineTile _buildTimelineTile({
    _IconIndicator? indicator,
    String? hour,
    String? title,
    String? desc,
    bool isLast = false,
    bool isFast = false,
    BuildContext? context
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.35,
      beforeLineStyle: const LineStyle(color: kTimelineColor, thickness: 1.0),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3,
        drawGap: true,
        width: 20,
        height: 20,
        indicator: indicator,
      ),
      isLast: isLast,
      isFirst: isFast,
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            hour!,
            textAlign: TextAlign.center,
            style: Theme.of(context!).textTheme.headline2!.copyWith(
              color: Get.isDarkMode ? kStUnderLineColor : kStUnderLineColor2,
            ),
          ),
        ),
      ),
      endChild: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 0, bottom: 10),
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title ?? "",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 4),
            Text(
              desc ?? "",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Get.isDarkMode ? kStUnderLineColor : kStUnderLineColor2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kTimelineColor,
          ),
        ),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}
