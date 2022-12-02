import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/address_book_controller.dart';
import 'package:woogoods/models/response/address_book.dart';
import 'package:woogoods/view/screens/account/components/widgets/profile_button2.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';

import '../../../main.dart';

class AddressBookScreen extends StatelessWidget {
  static const routeName = 'address_book_screen';

  final AddressBook? data;
  final bool isNew;

  const AddressBookScreen({
    Key? key,
    this.data,
    this.isNew = false,
  }) : super(key: key);

  Future<void> _loadData(bool newData) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (newData) {
        Get.find<AddressBookController>().clearAddress();
      } else {
        Get.find<AddressBookController>().setSelectedAddress(data!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(isNew);

    return Scaffold(
      appBar: AppBar(
        title: Text('Address details'.tr),
      ),
      body: GetBuilder<AddressBookController>(
        builder: (addressController) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'First Name:'.tr,
                                              style: kRegularText2.copyWith(
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
                                              ),
                                            ),
                                            InputFormWidget(
                                              fieldController: addressController
                                                  .fNameController,
                                              hintText: 'Enter first name'.tr,
                                            ),
                                          ],
                                        ),
                                      ),
                                      kWidthBox10,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Last Name:'.tr,
                                              style: kRegularText2.copyWith(
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
                                              ),
                                            ),
                                            InputFormWidget(
                                              fieldController: addressController
                                                  .lNameController,
                                              hintText: 'Enter last name'.tr,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Contact Number:'.tr,
                                    style: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),
                                  ),
                                  InputFormWidget(
                                    fieldController:
                                        addressController.phoneController,
                                    hintText: 'Please enter phone number'.tr,
                                    isCountry: true,
                                    selectionCountryCode:
                                        addressController.selectionCountryCode,
                                    onCountryChange: (value) {
                                      log(
                                        value.toString(),
                                      );
                                      addressController.changeCountryCodeValue(
                                        value.toString(),
                                      );
                                    },
                                    keyType: TextInputType.phone,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Country'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    ],
                                  ),
                                  kHeightBox10,
                                  CSCPicker(
                                    layout: Layout.vertical,

                                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                    showStates: true,

                                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                                    showCities: true,

                                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                    flagState: CountryFlag.DISABLE,

                                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                          color: kStUnderLineColor, width: .3),
                                    ),

                                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                    disabledDropdownDecoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(
                                            color: kStUnderLineColor,
                                            width: .3)),

                                    ///placeholders for dropdown search field
                                    countrySearchPlaceholder:
                                        'Search region'.tr,
                                    stateSearchPlaceholder: 'Search state'.tr,
                                    citySearchPlaceholder: 'Search city'.tr,

                                    ///labels for dropdown
                                    countryDropdownLabel: 'Country'.tr,
                                    stateDropdownLabel: 'State'.tr,
                                    cityDropdownLabel: 'City'.tr,

                                    ///Current select
                                    currentCountry:
                                        isNew ? null : data?.country ?? '',
                                    currentState:
                                        isNew ? null : data?.state ?? '',
                                    currentCity:
                                        isNew ? null : data?.city ?? '',

                                    ///Default Country
                                    //defaultCountry: isNew ? DefaultCountry.Bangladesh : null,

                                    ///Disable country dropdown (Note: use it with default country)
                                    //disableCountry: true,

                                    ///selected item style [OPTIONAL PARAMETER]
                                    selectedItemStyle: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),

                                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                    dropdownHeadingStyle:
                                        kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),

                                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                    dropdownItemStyle: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                      fontSize: 14.0,
                                    ),

                                    ///Dialog box radius [OPTIONAL PARAMETER]
                                    dropdownDialogRadius: 5.0,

                                    ///Search bar radius [OPTIONAL PARAMETER]
                                    searchBarRadius: 5.0,

                                    ///triggers once country selected in dropdown
                                    onCountryChanged: (value) {
                                      ///store value in country variable
                                      addressController
                                          .changeCountryValue(value);
                                    },

                                    ///triggers once state selected in dropdown
                                    onStateChanged: (value) {
                                      ///store value in state variable
                                      addressController
                                          .changeStateValue(value ?? "Dhaka");
                                    },

                                    ///triggers once city selected in dropdown
                                    onCityChanged: (value) {
                                      ///store value in city variable
                                      addressController
                                          .changeCitiesValue(value ?? "Dhaka");
                                    },
                                  ),
                                  kHeightBox10,
                                  Text(
                                    'Post Code:'.tr,
                                    style: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),
                                  ),
                                  InputFormWidget(
                                    fieldController:
                                        addressController.postCodeController,
                                    hintText: 'Enter postal code'.tr,
                                  ),
                                  Text(
                                    'Address Detail:'.tr,
                                    style: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),
                                  ),
                                  InputFormWidget(
                                    fieldController:
                                        addressController.addressController,
                                    hintText:
                                        'Please enter the details of the address'
                                            .tr,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        kHeightBox10,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                addressController.changeLabelAs('Home');
                              },
                              child: addressController.selectLabel == 'Home'
                                  ? selectedLabel(context, 'Home')
                                  : unselectedLabel(context, 'Home'),
                            ),
                            kWidthBox10,
                            InkWell(
                              onTap: () {
                                addressController.changeLabelAs('Office');
                              },
                              child: addressController.selectLabel == 'Office'
                                  ? selectedLabel(context, 'Office')
                                  : unselectedLabel(context, 'Office'),
                            ),
                          ],
                        ),
                        kHeightBox10,
                        ProfileButton2(
                          bgColor: Theme.of(context).cardColor,
                          height: getProportionateScreenHeight(42.0),
                          radius: 5.0,
                          title: 'Selected Address'.tr,
                          elevation: 1.0,
                          isButtonActive: addressController.selectedAddress,
                          onTap: () {
                            addressController.changeSelectAddress();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                color: Theme.of(context).cardColor,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: DefaultBtn(
                    width: SizeConfig.screenWidth,
                    height: 40,
                    radius: 5.0,
                    title: isNew ? 'Save'.tr : 'Update'.tr,
                    onPress: () {
                      log(addressController.cityValue);

                      if (addressController.fNameController.text.isEmpty) {
                        showCustomSnackBar('Please enter your first name'.tr);
                      } else if (addressController
                          .lNameController.text.isEmpty) {
                        showCustomSnackBar('Please enter your last name'.tr);
                      } else if (addressController
                          .phoneController.text.isEmpty) {
                        showCustomSnackBar('Please enter your phone number'.tr);
                      } else if (addressController.countryValue.isEmpty) {
                        showCustomSnackBar('Please select country'.tr);
                      } else if (addressController.stateValue.isEmpty) {
                        showCustomSnackBar('Please select state'.tr);
                      } else if (addressController.cityValue.isEmpty) {
                        showCustomSnackBar('Please select city'.tr);
                      } else if (addressController
                          .postCodeController.text.isEmpty) {
                        showCustomSnackBar('Please enter postal code'.tr);
                      } else if (addressController
                          .addressController.text.isEmpty) {
                        showCustomSnackBar('Please enter your address'.tr);
                      } else {
                        addressController.addToAddress(
                          AddressBook(
                            id: addressController.addressList.isEmpty
                                ? null
                                : data?.id,
                            firstName: addressController.fNameController.text,
                            lastName: addressController.lNameController.text,
                            email: prefs.getString(userEmail) ?? '',
                            phone: addressController.phoneController.text,
                            countyCode: addressController.selectionCountryCode,
                            country: addressController.countryValue,
                            city: addressController.cityValue,
                            state: addressController.stateValue,
                            postcode: addressController.postCodeController.text,
                            address: addressController.addressController.text,
                            labelAs: addressController.selectLabel,
                            isSelect: addressController.addressList.isEmpty
                                ? 1
                                : addressController.selectedAddress
                                    ? 1
                                    : 0,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget selectedLabel(BuildContext context, String home) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            kSecondaryColor,
            kPrimaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      height: getProportionateScreenHeight(34.0),
      child: Center(
        child: Text(
          home.tr,
          style: kSmallText.copyWith(
            color: kWhiteColor,
            fontSize: 10.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget unselectedLabel(BuildContext context, String office) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: .5, color: kStUnderLineColor),
      ),
      height: getProportionateScreenHeight(34.0),
      child: Center(
        child: Text(
          office.tr,
          style: kSmallText.copyWith(
            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
            fontSize: 10.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
