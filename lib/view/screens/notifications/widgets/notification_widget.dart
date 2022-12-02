
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:woogoods/constants/images.dart';

import '../../../../constants/colors_data.dart';
import '../../../../constants/size_config.dart';
import '../../../../constants/style_data.dart';

class NotificationWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  final Function? onPress;
  final bool? isLast;
  const NotificationWidget({
    Key? key,
    this.title,
    this.image,
    this.onPress,
    this.subTitle,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: .5,
              color: isLast == false ? kOrdinaryColor : kWhiteColor,
            ),
          ),
        ),
        child: ListTile(
          leading: SizedBox(
            width: getProportionateScreenWidth(60),
            height: getProportionateScreenWidth(50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image !=null ?  CachedNetworkImage(
                imageUrl: image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Image.asset(Images.placeHolder, fit: BoxFit.cover,),
                errorWidget: (context, url, error) =>
                    Image.asset(Images.placeHolder, fit: BoxFit.cover,),
              ) : Image.asset(
                Images.placeHolder,
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(
            title ?? '',
            style: kRegularText2.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
          subtitle: Text(
            subTitle ?? '',
            style: kDescriptionText,
          ),
         /* trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),*/
        ),
      ),
    );
  }
}
