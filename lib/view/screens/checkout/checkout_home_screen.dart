import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/address_book_controller.dart';
import 'package:woogoods/controllers/checkout_controller.dart';
import 'package:woogoods/controllers/coupon_controller.dart';
import 'package:woogoods/models/body/create_order.dart';
import 'package:woogoods/models/response/address_book.dart';
import 'package:woogoods/models/response/cart_model.dart';
import 'package:woogoods/view/screens/checkout/widgets/address_view.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';
import '../../../main.dart';
import 'widgets/checkout_product_card.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = 'checkout_home_screen';

  final List<CartModel> cartData;
  final int totalPrice;
  final int totalQuantity;
  final bool isCart;

  const CheckoutScreen({
    Key? key,
    required this.cartData,
    required this.totalPrice,
    required this.totalQuantity,
    this.isCart = true,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

/*  final plugin = PaystackPlugin();
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  @override
  void initState() {
    plugin.initialize(publicKey: kPayStackPublicKey,);
    super.initState();
  }*/

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<AddressBookController>().getAllAddressList();
    });
    Get.find<CheckoutController>().deleteDiscountPrice();
    Get.find<CheckoutController>().getUserData();
    Get.find<CheckoutController>().fetchShippingZone();
    Get.find<CheckoutController>().productData(cartData: widget.cartData);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Order'.tr),
      ),
      body: GetBuilder<CheckoutController>(
        builder: (checkoutController) {
       /*   WidgetsBinding.instance.addPostFrameCallback((_) async {
            if(checkoutController.paymentMethod == 'paystack' && checkoutController.isOrderPlace && checkoutController.payStackCalled == false){
              checkoutController.updatePayStackCalled();
             handlePayStackCheckout(context, ((widget.totalPrice + checkoutController.shippingFee) - (checkoutController.discountPrice)), checkoutController.createOrder!,);
            }
          });*/
          return GetBuilder<AddressBookController>(
              builder: (addressController) {

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        kHeightBox10,
                        AddressView(
                          isAddress: addressController.isCheckout
                              ? true
                              : addressController.selectedItemAddress != null
                                  ? true
                                  : false,
                          addressBook: addressController.isCheckout
                              ? addressController.selectCheckoutAddress
                              : addressController.selectedItemAddress,
                        ),
                        kHeightBox10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: SizeConfig.screenWidth,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 12, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Products'.tr,
                                          style: kRegularText2.copyWith(
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => checkoutController
                                            .changeProductExpanded(),
                                        child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: SvgPicture.asset(
                                            checkoutController.productExpanded
                                                ? Images.dropTop
                                                : Images.dropDown,
                                            width: 12,
                                            height: 12,
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                kHeightBox10,
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  height: .3,
                                  color: kStUnderLineColor,
                                ),
                                kHeightBox10,
                                Container(
                                  child: checkoutController.productExpanded
                                      ? Column(
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: widget.cartData.length,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (context, int index) {
                                                return CheckoutProductCard(
                                                  data: widget.cartData[index],
                                                );
                                              },
                                            ),
                                            kHeightBox5,
                                            Container(
                                              height: .3,
                                              color: kStUnderLineColor,
                                            ),
                                            kHeightBox5,
                                            Container(
                                              alignment: Alignment.centerRight,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Total: '.tr,
                                                      style: kRegularText2
                                                          .copyWith(
                                                        color: kBlackColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: kCurrency +
                                                          '${widget.totalPrice}.00',
                                                      style: kRegularText2
                                                          .copyWith(
                                                              color:
                                                                  kPrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            kHeightBox10,
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        kHeightBox10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Sub Total:'.tr,
                                          style: kRegularText2.copyWith(
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        kCurrency + '${widget.totalPrice}.00',
                                        style: kRegularText2.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kHeightBox10,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Shipping Fee:'.tr,
                                          style: kRegularText2.copyWith(
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        kCurrency +
                                            '${checkoutController.shippingFee}.00',
                                        style: kRegularText2.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      child: checkoutController.isDiscount
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                kHeightBox10,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'Voucher Discount:'.tr,
                                                        style: kRegularText2
                                                            .copyWith(
                                                          color: Get.isDarkMode
                                                              ? kWhiteColor
                                                              : kBlackColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '- $kCurrency${checkoutController.discountPrice}.00',
                                                      style: kRegularText2
                                                          .copyWith(
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const SizedBox()),
                                  kHeightBox5,
                                ],
                              ),
                            ),
                          ),
                        ),
                        kHeightBox10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: SizeConfig.screenWidth,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            elevation: 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 12, right: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Payment method (Required)'.tr,
                                          style: kRegularText2.copyWith(
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => checkoutController
                                            .changePaymentExpanded(),
                                        child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: SvgPicture.asset(
                                            checkoutController.paymentExpanded
                                                ? Images.dropTop
                                                : Images.dropDown,
                                            width: 12,
                                            height: 12,
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                kHeightBox10,
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  height: .3,
                                  color: kStUnderLineColor,
                                ),
                                kHeightBox10,
                                InkWell(
                                  onTap: () {
                                    checkoutController.updatePaymentMethod(
                                      id: 'cod',
                                      title: 'Cash on delivery',
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            kWidthBox10,
                                            checkoutController.paymentMethod ==
                                                    'cod'
                                                ? SizedBox(
                                                    width: 22,
                                                    height: 22,
                                                    child: SvgPicture.asset(
                                                      Images.circleCheck,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset(
                                                      Images.circleOutline,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        kWidthBox10,
                                        Text(
                                          'Cash on Delivery'.tr,
                                          style: kRegularText2.copyWith(
                                            color: Get.isDarkMode
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                kHeightBox10,
                                Container(
                                  child: checkoutController.paymentExpanded
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: checkoutController
                                              .paymentGatewayList.length,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, int index) {
                                            return InkWell(
                                              onTap: () {
                                                checkoutController.updatePaymentMethod(
                                                    id: checkoutController
                                                                .paymentGatewayList[
                                                            index]["id"] ??
                                                        '',
                                                    title: checkoutController
                                                                .paymentGatewayList[
                                                            index]["title"] ??
                                                        '');
                                              },
                                              child: buildPaymentMethodCard(
                                                index,
                                                checkoutController
                                                    .paymentGatewayList[index],
                                                checkoutController
                                                                .paymentGatewayList[
                                                            index]["id"] ==
                                                        checkoutController
                                                            .paymentMethod
                                                    ? true
                                                    : false,
                                              ),
                                            );
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        kHeightBox10,
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Row(
                            children: [
                              kWidthBox10,
                              Expanded(
                                child: InputFormWidget(
                                  fieldController:
                                      checkoutController.couponController,
                                  hintText: 'Enter Voucher Code'.tr,
                                  height: 40,
                                  maxLines: 1,
                                ),
                              ),
                              kWidthBox10,
                              DefaultBtn(
                                radius: 5.0,
                                title: 'APPLY'.tr,
                                height: 40,
                                btnColor: Theme.of(context).cardColor,
                                btnColor2: Theme.of(context).cardColor,
                                borderColor: Colors.transparent,
                                textColor:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor,
                                onPress: () {
                                  if (checkoutController.isDiscount) {
                                    showCustomSnackBar(
                                        'Voucher already used!'.tr);
                                  } else {
                                    if (checkoutController
                                        .couponController.text.isNotEmpty) {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              const CustomLoader());
                                      Get.find<CouponController>().applyCoupon(
                                          context,
                                          code: checkoutController
                                              .couponController.text,
                                          totalPrice: (widget.totalPrice +
                                              checkoutController.shippingFee),
                                          quantity: widget.totalQuantity);
                                    } else {
                                      showCustomSnackBar(
                                          'Please enter your voucher code'.tr);
                                    }
                                  }
                                },
                              ),
                              kWidthBox10,
                            ],
                          ),
                        ),
                        kHeightBox10,
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kWidthBox10,
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Pay Amount:'.tr,
                                      style: kRegularText2.copyWith(
                                        color: Get.isDarkMode
                                            ? kWhiteColor
                                            : kBlackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: kCurrency +
                                          '${((widget.totalPrice + checkoutController.shippingFee) - (checkoutController.discountPrice))}.00',
                                      style: kAppBarText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                          color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        kWidthBox10,
                        DefaultBtn(
                          radius: 5.0,
                          title: 'Place Order'.tr,
                          height: 40,
                          onPress: () {
                            if (addressController.isCheckout ||
                                addressController.selectedItemAddress != null) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const CustomLoader());
                              checkoutController.createOrderFromServer(context,
                                  shipping: getShippingData(
                                    addressBook: addressController.isCheckout
                                        ? addressController
                                            .selectCheckoutAddress
                                        : addressController.selectedItemAddress,
                                  ),
                                  billing: getBillingData(
                                    addressBook: addressController.isCheckout
                                        ? addressController
                                            .selectCheckoutAddress
                                        : addressController.selectedItemAddress,
                                  ),
                                  totalPrice: '${((widget.totalPrice + checkoutController.shippingFee) - (checkoutController.discountPrice))}',
                                  subtotal: widget.totalPrice.toString(),
                                setPaid: checkoutController.paymentMethod == 'bacs'  ? true : false
                              );
                            } else {
                              showCustomSnackBar(
                                  'Please added shipping address');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Shipping getShippingData({AddressBook? addressBook}) {
    log(addressBook?.lastName ?? '');
    Shipping shipping = Shipping(
      firstName: addressBook?.firstName ?? '',
      lastName: addressBook?.lastName ?? '',
      country: addressBook?.country ?? '',
      state: addressBook?.state ?? '',
      city: addressBook?.city ?? '',
      address1: addressBook?.address ?? '',
      address2: '',
      postcode: addressBook?.postcode ?? '',
    );
    return shipping;
  }

  Billing getBillingData({
    AddressBook? addressBook,
  }) {
    Billing shipping = Billing(
      firstName: addressBook?.firstName ?? '',
      lastName: addressBook?.lastName ?? '',
      email: prefs.getString(userEmail) ?? '',
      phone: '(${addressBook?.countyCode ?? ''}) ${addressBook?.phone ?? ''}',
      country: addressBook?.country ?? '',
      state: addressBook?.state ?? '',
      city: addressBook?.city ?? '',
      address1: addressBook?.address ?? '',
      address2: '',
      postcode: addressBook?.postcode ?? '',
    );
    return shipping;
  }

  buildPaymentMethodCard(
      int index, Map<String, String> paymentGatewayList, bool selected) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  kWidthBox10,
                  selected
                      ? SvgPicture.asset(
                          Images.circleCheck,
                          width: 22,
                          height: 22,
                        )
                      : SvgPicture.asset(
                          Images.circleOutline,
                          width: 20,
                          height: 20,
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                        ),
                ],
              ),
              kWidthBox10,
              if((paymentGatewayList["id"] ?? '') == 'bacs')Text(
                  'Direct Bank Transfer',
                  style: kRegularText2.copyWith(
                    color: const Color(0xFF00C3F7),
                  ),
                ),
              if(!((paymentGatewayList["id"] ?? '') == 'bacs'))
              SvgPicture.asset(
                paymentGatewayList["image"] ?? '',
                height: 20,
                color: Get.isDarkMode ? kWhiteColor : null,
              ),
            ],
          ),
        ),
        kHeightBox10,
      ],
    );
  }


/*  Future<void> handlePayStackCheckout(BuildContext context, int totalPrice, CreateOrder order) async {
    Charge charge = Charge()
   // ..currency ='USD'
      ..amount = totalPrice // In base currency
      ..email = order.billing?.email ?? ''
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: const MyLogo(),
      );
      log('Response = $response');

      if(response.status == true){
        Get.off(() => const DashBoardScreen());
        Get.find<CartController>().getAllCartList();
        showCustomSnackBar('Payment success', isError: false);

      }else{
        showCustomSnackBar(response.message, isError: !(response.status),);
      }

    } catch (e) {
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }*/
}

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
