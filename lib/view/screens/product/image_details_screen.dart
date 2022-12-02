import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/models/response/product_list.dart' as model;

class ImageDetailsScreen extends StatefulWidget {
  static const routeName = 'image_details';
  final List<model.ProductImages>? images;
  const ImageDetailsScreen({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
  List products = [
    'https://cdn.nazmiyalantiquerugs.com/wp-content/uploads/2012/02/1990s-womens-fashion-trends-high-cut-off-short-shorts-nazmiyal-antique-rugs.jpg',
    'https://asset2.cxnmarksandspencer.com/is/image/mands/0205_11022021_SB-27353_Mosaic_1858x1858_1?wid=950&qlt=70&fmt=pjpeg',
    'https://s3-media0.fl.yelpcdn.com/bphoto/zixI3n0X9bnjcI19pFubHg/l.jpg',
    'https://i.pinimg.com/originals/3b/46/f9/3b46f9a6aa22591d26776d35ed237751.jpg',
  ];
  int productIndex = 0;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: kCardDarkColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: kWhiteColor,
          systemNavigationBarDividerColor: kWhiteColor,
        ),
      ),
      backgroundColor: kBlackColor2,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(
                        top: 0,
                      ),
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.close, size: 18, color: kBlackColor2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: widget.images!.length,
                onPageChanged: (int index) {
                  setState(() {
                    productIndex = index;
                  });
                },
                itemBuilder: (context, index) => Container(
                  child: isImageShow
                      ? Container(
                          color: kBlackColor2,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: widget.images![productIndex].src!,
                            fit: BoxFit.fitHeight,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                color: kOrdinaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              //height: getProportionateScreenWidth(95),
                              //  width: getProportionateScreenWidth(95),
                              child: Image.asset(Images.placeHolder),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                color: kOrdinaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.asset(kImageDir + 'placeholder.png'),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: kOrdinaryColor2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //height: getProportionateScreenWidth(95),
                          //  width: getProportionateScreenWidth(95),
                          child: Image.asset(Images.placeHolder),
                        ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SizedBox(
                height: 60,
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        controller.jumpToPage(index);
                      },
                      child: Container(
                        width: 40,
                        height: 80,
                        decoration: BoxDecoration(
                          color: kOrdinaryColor2,
                          border: Border.all(
                            width: 1,
                            color: productIndex == index
                                ? kPrimaryColor
                                : kWhiteColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: isImageShow
                            ? CachedNetworkImage(
                                imageUrl: widget.images![index].src!,
                                fit: BoxFit.fitHeight,
                                placeholder: (context, url) => Container(
                                  width: 40,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //height: getProportionateScreenWidth(95),
                                  //  width: getProportionateScreenWidth(95),
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
                              )
                            : Container(
                                width: 40,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: kOrdinaryColor2,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                //height: getProportionateScreenWidth(95),
                                //  width: getProportionateScreenWidth(95),
                                child: Image.asset(Images.placeHolder),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
