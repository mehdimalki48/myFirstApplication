import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/services/api/app_config.dart';

import '../constants/strings.dart';
import '../constants/style_data.dart';
import '../controllers/cart_controller.dart';
import '../view/screens/dashboard/dashboard_screen.dart';

class PaymentHelper {
  late Map<String, dynamic> paymentIntentData;

  Future<void> makePayment({
    required BuildContext context,
    required String amount,
  }) async {
    if(kSecretKey.isEmpty){
      showCustomSnackBar('Your Stripe secret key hare');
      return;
    }
    try {
      paymentIntentData = await createPaymentIntent(amount, 'USD');
      //json.decode(response.body);
      // log('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              applePay: const PaymentSheetApplePay(
                merchantCountryCode: 'US',
              ),
              googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: 'US',
                testEnv: false,
              ),
              style: ThemeMode.light,
              merchantDisplayName: appName,
             /* billingDetails: const BillingDetails(
                name: 'Flutter Stripe',
                email: 'email@stripe.com',
                phone: '+48888000888',
                address: Address(city: city, country: country, line1: line1, line2: line2, postalCode: postalCode, state: state)
              )*/
            ),
          )
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(
        context: context,
      );
    } catch (e, s) {
      log('exception:$e$s');
    }
  }

  displayPaymentSheet({
    required BuildContext context,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        log('payment intent' + paymentIntentData['id'].toString());
        log('payment intent' + paymentIntentData['client_secret'].toString());
        log('payment intent' + paymentIntentData['amount'].toString());
        log('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        Get.off(() => const DashBoardScreen());
        Get.find<CartController>().getAllCartList();
        showCustomSnackBar('Paid successfully', isError: false,);

        paymentIntentData = {};
      }).onError((error, stackTrace) {
        log('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      log('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      log('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      log(body.toString());
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $kSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      log('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      log('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
