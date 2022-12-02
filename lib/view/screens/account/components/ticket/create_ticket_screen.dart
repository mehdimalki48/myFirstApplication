import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/ticket_image.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';

class CreateTicketScreen extends StatefulWidget {
  static const routeName = 'create_ticket_screen';
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedPriority;
  String? selectedDepartment;
  var priorityFilter = [
    'Low',
    'Medium',
    'High',
  ];
  var departmentFilter = [
    'Sales',
    'Return',
    'General Equipments',
  ];
  int attachments = 2;
  //Add image
  final picker = ImagePicker();
  File? thumbnailImage;
  String? thumbnailBase64;

  List<TicketImage> ticketImageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ticket'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      child: Card(
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ticket subject'.tr,
                                  style: Theme.of(context).textTheme.headline2),
                              InputFormWidget(
                                fieldController: nameController,
                                hintText: 'Subject'.tr,
                                maxLines: 1,
                                height: getProportionateScreenHeight(40),
                              ),
                              Text('Your E-mail Address'.tr,
                                  style: Theme.of(context).textTheme.headline2),
                              InputFormWidget(
                                fieldController: emailController,
                                hintText: 'E-mail Address'.tr,
                                keyType: TextInputType.emailAddress,
                                maxLines: 1,
                                height: getProportionateScreenHeight(40),
                              ),
                              Text('Message'.tr,
                                  style: Theme.of(context).textTheme.headline2),
                              InputFormWidget(
                                fieldController: addressController,
                                hintText: 'Type a message'.tr,
                                maxLines: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenWidth! / 2.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Priority'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2),
                                        kHeightBox10,
                                        Container(
                                          height: getProportionateScreenHeight(
                                              40.0),
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(
                                                width: .3,
                                                color: kStUnderLineColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: DropdownButton<String>(
                                              underline: const SizedBox(),
                                              value: selectedPriority,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
                                              ),
                                              hint: Text(
                                                'Low',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              items: priorityFilter.map(
                                                (e) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: SizedBox(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          2.9,
                                                      child: Text(
                                                        e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2,
                                                      ),
                                                    ),
                                                    value: e,
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedPriority = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth! / 2.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Department'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2),
                                        kHeightBox10,
                                        Container(
                                          height: getProportionateScreenHeight(
                                              40.0),
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(
                                                width: .3,
                                                color: kStUnderLineColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: DropdownButton<String>(
                                              underline: const SizedBox(),
                                              value: selectedDepartment,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
                                              ),
                                              hint: Text(
                                                'Sales',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              items: departmentFilter.map(
                                                (e) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: SizedBox(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          2.9,
                                                      child: Text(
                                                        e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2,
                                                      ),
                                                    ),
                                                    value: e,
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedDepartment = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              Text('Attachments'.tr,
                                  style: Theme.of(context).textTheme.headline2),
                              kHeightBox10,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: ticketImageList.isNotEmpty
                                              ? Column(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            ticketImageList
                                                                .length;
                                                        i++)
                                                      Column(
                                                        children: [
                                                          DottedBorder(
                                                            color: kFbColors,
                                                            borderType:
                                                                BorderType
                                                                    .RRect,
                                                            strokeWidth: 1,
                                                            radius: const Radius
                                                                .circular(5),
                                                            child: Container(
                                                              color: const Color(
                                                                  0xFFD5E7FF),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 10,
                                                                horizontal: 15,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      ticketImageList[
                                                                              i]
                                                                          .path,
                                                                      maxLines:
                                                                          2,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline2!
                                                                          .copyWith(
                                                                            color:
                                                                                kStUnderLineColor,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          kHeightBox10,
                                                        ],
                                                      ),
                                                  ],
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                        for (int i = 0; i < attachments; i++)
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () => uploadImage(),
                                                child: DottedBorder(
                                                  color: kFbColors,
                                                  borderType: BorderType.RRect,
                                                  strokeWidth: 1,
                                                  radius:
                                                      const Radius.circular(5),
                                                  child: Container(
                                                    color:
                                                        const Color(0xFFD5E7FF),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Add Image'.tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2!
                                                                  .copyWith(
                                                                    color:
                                                                        kStUnderLineColor,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kHeightBox10,
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  kWidthBox10,
                                  InkWell(
                                    onTap: () => setState(() {
                                      ++attachments;
                                    }),
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(
                                        top: 0,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: kFbColors,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.add,
                                            size: 18, color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    kHeightBox10,
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            color: Theme.of(context).cardColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: DefaultBtn(
                width: SizeConfig.screenWidth,
                height: 40,
                radius: 5.0,
                title: 'Save'.tr,
                onPress: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadImage() {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 80,
                height: 5,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? kWhiteColor
                        : kStUnderLineColor2.withOpacity(.5),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            kHeightBox15,
            textRoboto(
              "Upload Image".tr,
              Get.isDarkMode ? kWhiteColor : kBlackColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            kHeightBox10,
            const Divider(
              thickness: .3,
              height: .3,
              color: kStUnderLineColor2,
            ),
            kHeightBox20,
            InkWell(
              onTap: () {
                Get.back();
                _getThumbnailImage(
                  type: ImageSource.camera,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kOrdinaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ),
                  kWidthBox20,
                  textRoboto(
                      "From Camera", Get.isDarkMode ? kWhiteColor : kBlackColor,
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ],
              ),
            ),
            kHeightBox20,
            InkWell(
              onTap: () {
                Get.back();
                _getThumbnailImage(
                  type: ImageSource.gallery,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kOrdinaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.perm_media,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ),
                  kWidthBox20,
                  textRoboto("From Gallery",
                      Get.isDarkMode ? kWhiteColor : kBlackColor,
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ],
              ),
            ),
            kHeightBox20,
          ],
        ),
      ),
    );
  }

  Future<void> _getThumbnailImage({ImageSource? type}) async {
    final pickedFile = await picker.pickImage(source: type!);

    if (pickedFile != null) {
      setState(() {
        thumbnailImage = File(pickedFile.path);
        thumbnailBase64 = base64Encode(thumbnailImage!.readAsBytesSync());
        log(thumbnailImage.toString());

        ticketImageList
            .add(TicketImage(id: 0, path: thumbnailImage!.path.toString()));
        --attachments;
      });
    } else {
      kErrorSnack(
        msg: 'No Image Selected',
      );
    }
  }
}
