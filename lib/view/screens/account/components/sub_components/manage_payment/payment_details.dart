import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final TextEditingController cardNumberController = TextEditingController();
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Details'.tr,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  kHeightBox20,
                  CreditCard(
                    cardType: CardType.visa,
                    cardNumber: cardNumber,
                    cardExpiry: expiryDate,
                    cardHolderName: cardHolderName,
                    cvv: cvv,
                    bankName: 'Visa Card',
                    showBackSide: showBack,
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                  ),
                  kHeightBox20,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Card Number'.tr,
                            // labelStyle: kDescriptionText.copyWith(
                            //   color: kStUnderLineColor,
                            // ),
                            focusColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 19,
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Card Expiry'.tr,
                            // labelStyle: kDescriptionText.copyWith(
                            //   color: kStUnderLineColor,
                            // ),
                            focusColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          maxLength: 5,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            setState(() {
                              expiryDate = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Card Holder Name'.tr,
                            // labelStyle: kDescriptionText.copyWith(
                            //   color: kStUnderLineColor,
                            // ),
                            focusColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            setState(() {
                              cardHolderName = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'CVV'.tr,
                            // labelStyle: kDescriptionText.copyWith(
                            //   color: kStUnderLineColor,
                            // ),
                            focusColor: kPrimaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          onChanged: (value) {
                            setState(() {
                              cvv = value;
                            });
                          },
                          focusNode: _focusNode,
                        ),
                      ),
                    ],
                  )
                ],
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
}
