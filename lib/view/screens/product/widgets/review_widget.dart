import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';

class ReviewWidget extends StatelessWidget {
  final bool? showImage;
  final Color? color;
  final String? userName;

  final String? userImage;
  final int? rating;
  final String? date;
  final String? reviewDetails;
  const ReviewWidget({
    Key? key,
    this.showImage = false,
    this.color,
    this.userImage,
    this.userName,
    this.rating,
    this.date,
    this.reviewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeightBox10,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  userImage ??
                      'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenWidth(35),
                  fit: BoxFit.fitHeight,
                ),
              ),
              kWidthBox10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName!,
                    style: kRegularText2.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    ),
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: double.parse(rating.toString()),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      kWidthBox5,
                      Text(
                        '$rating',
                        style: kSmallText.copyWith(
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kWidthBox5,
                      Container(
                        height: 10,
                        width: 1,
                        color: Get.isDarkMode
                            ? kWhiteColor
                            : const Color(0xFF808080),
                      ),
                      kWidthBox10,
                      Text(
                        DateFormat('d/MM/yy hh.mm a').format(
                          DateTime.parse(date!),
                        ),
                        style: kSmallText.copyWith(
                          color: Get.isDarkMode
                              ? kWhiteColor
                              : const Color(0xFF808080),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          kHeightBox10,
          Text(
            reviewDetails ?? '',
            style: kRegularText2.copyWith(
              color: Get.isDarkMode ? kWhiteColor : const Color(0xFF303030),
            ),
          ),
          kHeightBox10,
          showImage == false
              ? const SizedBox()
              : SizedBox(
                  height: 100,
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, int index) {
                      return Container(
                        child: isImageShow
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.luxe.digital/media/2020/05/04080413/best-overall-men-sneakers-oliver-cabell-low-top-white-luxe-digital.png',
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      color: kOrdinaryColor2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image.asset(Images.placeHolder),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          color: kOrdinaryColor2,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Image.asset(kImageDir + 'placeholder.png'),
                                      ),
                                  width: getProportionateScreenWidth(80),
                                  height: getProportionateScreenWidth(80),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: kOrdinaryColor2,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: getProportionateScreenWidth(80),
                                height: getProportionateScreenWidth(80),
                                child: Image.asset(Images.placeHolder),
                              ),
                      );
                    },
                  ),
                ),
          kHeightBox10,
          const Divider(
            thickness: .3,
            height: .3,
            color: Color(0xFF808080),
          ),
        ],
      ),
    );
  }
}
