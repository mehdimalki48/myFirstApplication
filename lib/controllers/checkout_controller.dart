import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/body/create_order.dart';
import 'package:woogoods/models/response/cart_model.dart';
import 'package:woogoods/models/response/shipping_method_list.dart';
import 'package:woogoods/models/response/shipping_zone_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/api/app_config.dart';
import 'package:woogoods/services/repository/auth_repo.dart';
import 'package:woogoods/services/repository/order_repo.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';

import '../constants/strings.dart';
import '../helper/stripe_payment_helper.dart';
import '../models/body/line_items.dart';
import '../models/response/order_list.dart' as order_response;
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  final OrdersRepo orders;
  final AuthRepo authRepo;

  CheckoutController({required this.orders, required this.authRepo});

  //Init model

  final List<LineItems> _itemData = [];
  final List<ShippingZoneList> _shippingZoneList = [];
  final List<ShippingMethodList> _shippingMethodList = [];
  CreateOrder? _createOrder;
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  String selectedCurrency = "";

  //payment theod
  dynamic formData = {};
  late Razorpay _razorpay;
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = "";
  String sdkStatus = "";
  String sdkErrorCode = "";
  String sdkErrorMessage = "";
  String sdkErrorDescription = "";

  //Init
  bool _isLoading = false;
  bool _isOrderPlace = false;
  bool _payStackCalled = false;
  bool _productExpanded = true;
  bool _addressExpanded = false;
  bool _paymentExpanded = false;
  bool _isDiscount = false;
  String _couponCode = "";
  String _countryValue = "";
  String _stateValue = "";
  String _cityValue = "";
  final String _address = "";
  int _currentIndex = 0;
  int _shippingFee = 0;
  int _discountPrice = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();

  //final String _paymentMethod = "bacs";
  //final String _paymentMethodTitle = "Direct Bank Transfer";
  String _paymentMethod = "cod";
  String _paymentMethodTitle = "Cash on delivery";

  ///Encapsulation
  CreateOrder? get createOrder => _createOrder;

  bool get isLoading => _isLoading;

  bool get isOrderPlace => _isOrderPlace;

  bool get payStackCalled => _payStackCalled;

  bool get productExpanded => _productExpanded;

  bool get addressExpanded => _addressExpanded;

  bool get paymentExpanded => _paymentExpanded;

  bool get isDiscount => _isDiscount;

  String get countryValue => _countryValue;

  String get stateValue => _stateValue;

  String get cityValue => _cityValue;

  String get address => _address;

  String get paymentMethod => _paymentMethod;

  String get paymentMethodTitle => _paymentMethodTitle;

  String get couponCode => _couponCode;

  List<LineItems> get itemData => _itemData;

  List<ShippingZoneList> get shippingZoneList => _shippingZoneList;

  List<ShippingMethodList> get shippingMethodList => _shippingMethodList;

  int get currentIndex => _currentIndex;

  int get shippingFee => _shippingFee;

  int get discountPrice => _discountPrice;

  TextEditingController get nameController => _nameController;

  TextEditingController get phoneController => _phoneController;

  TextEditingController get addressController => _addressController;

  TextEditingController get couponController => _couponController;
  final List<Map<String, String>> paymentGatewayList = [
    {"id": "bacs", "title": "Direct Bank Transfer", "image": Images.paytm},
    {"id": "stripe", "title": "Credit Card (Stripe)", "image": Images.stripe},
    {"id": "payuap", "title": "Paypal", "image": Images.paypal},
    /*  {
      "id": "paystack",
      "title": "Debit/Credit Cards (PayStack)",
      "image": Images.payStack
    },*/
    {
      "id": "braintree_credit_card",
      "title": "Credit Card(Braintree)",
      "image": Images.braintree
    },
    {
      "id": "sslcommerz",
      "title": "Pay Online(Credit/Debit Card/MobileBanking/NetBanking/bKash)",
      "image": Images.sslCommerz
    },
    {"id": "razorpay", "title": "Razorpay", "image": Images.razorpay},
    {"id": "paytm", "title": "Paytm", "image": Images.paytm},
  ];

  ///Create Order woocommerce
  Future<void> createOrderFromServer(
    BuildContext context, {
    required Shipping shipping,
    required Billing billing,
    String status = 'pending',
    bool setPaid = false,
    String totalPrice = '0',
    String subtotal = '0',
  }) async {
    _isLoading = true;
    _isOrderPlace = false;
    _payStackCalled = false;
    update();

    ///crate data add
    CreateOrder order = CreateOrder(
      paymentMethod: _paymentMethod,
      paymentMethodTitle: _paymentMethodTitle,
      status: status,
      setPaid: setPaid,
      customerId: int.parse(authRepo.getUserId()),
      total: "$totalPrice.00",
      billing: billing,
      shipping: shipping,
      shippingLines: shippingLineData(),
      lineItems: _itemData,
      couponLines: isDiscount ? couponLineData() : [],
    );
    var productList = jsonEncode(order);
    log(productList);
    final response = await orders.createOrder(createOrder: order);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      order_response.OrderList orderResponse =
          order_response.OrderList.fromJson(body);
      log('====> Http Response: $body');
      //dismiss dialog
      Navigator.of(context).pop();
      // delete cart all data
      Get.find<CartController>().emptyCart();
      _createOrder = order;
      _isLoading = false;
      update();
      if (_paymentMethod == 'cod' || _paymentMethod == 'bacs') {
        //open new class
        Get.off(() => const DashBoardScreen());
        Get.find<CartController>().getAllCartList();
        showCustomSnackBar('Your order place Successfully!', isError: false);
      } else if (_paymentMethod == 'stripe') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        await PaymentHelper().makePayment(
          context: context,
          amount: totalPrice,
        );
      } else if (_paymentMethod == 'payuap') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        if (kKokenizationKey.isEmpty) {
          showCustomSnackBar('Your Braintree Kokenization Key hare');
          return;
        }
        var request = BraintreeDropInRequest(
          tokenizationKey: kKokenizationKey,
          collectDeviceData: true,
          googlePaymentRequest: BraintreeGooglePaymentRequest(
            totalPrice: '$totalPrice.00',
            currencyCode: 'MAD',
            billingAddressRequired: false,
          ),
          paypalRequest: BraintreePayPalRequest(
            amount: '$totalPrice.00',
            displayName: appName,
            currencyCode: 'MAD',
          ),
          cardEnabled: true,
        );
        final result = await BraintreeDropIn.start(request);
        if (result != null) {
          showNonce(result.paymentMethodNonce, context);
        }
      } else if (_paymentMethod == 'rave') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        /*await handleFlutterWavePayment(
          context: context,
          amount: '$totalPrice.00',
          order: order,
        );*/
      } else if (_paymentMethod == 'braintree_credit_card') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        if (kKokenizationKey.isEmpty) {
          showCustomSnackBar('Your Braintree Kokenization Key hare');
          return;
        }
        var request = BraintreeDropInRequest(
          tokenizationKey: kKokenizationKey,
          collectDeviceData: true,
          googlePaymentRequest: BraintreeGooglePaymentRequest(
            totalPrice: '$totalPrice.00',
            currencyCode: 'MAD',
            billingAddressRequired: false,
          ),
          paypalRequest: BraintreePayPalRequest(
            amount: '$totalPrice.00',
            displayName: appName,
            currencyCode: 'MAD',
          ),
          cardEnabled: true,
        );
        final result = await BraintreeDropIn.start(request);
        if (result != null) {
          showNonce(result.paymentMethodNonce, context);
        }
      } /* else if (_paymentMethod == 'paystack') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        if (kPayStackPublicKey.isEmpty) {
          showCustomSnackBar('Your paystack public key hare');
          return;
        }
        _isOrderPlace = true;
        update();
      } */
      else if (_paymentMethod == 'sslcommerz') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        await sslCommercePayment(
          context: context,
          amount: totalPrice,
          order: order,
        );
      } else if (_paymentMethod == 'razorpay') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);

        razorPayOpenCheckout(
          context: context,
          amount: totalPrice,
          order: order,
        );
      } else if (_paymentMethod == 'paytm') {
        showCustomSnackBar(
            'Your order place Successfully. Please payment process complete then exit app.',
            isError: false);
        await startPaytmTransaction(
          context: context,
          amount: totalPrice,
          orderId: (orderResponse.id ?? 0).toString(),
        );
      }
    } else {
      _isLoading = false;
      _isOrderPlace = false;
      _payStackCalled = false;
      update();
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///get single order data
  Future<void> fetchShippingZone() async {
    _isLoading = true;
    update();

    final response = await orders.getShippingZone();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ShippingZoneList> posts = body
          .map(
            (dynamic item) => ShippingZoneList.fromJson(item),
          )
          .toList();
      log(response.body);
      if (body.isEmpty) {
        _isLoading = false;
        update();
        update();
        showCustomSnackBar('No more orders');
      } else {
        log('=================>> add log');
        _shippingZoneList.addAll(posts);
        _isLoading = false;
        update();

        if (_shippingZoneList.isNotEmpty) {
          for (int i = 0; i < _shippingZoneList.length; i++) {
            if ((_shippingZoneList[i].name ?? '') == 'Flat rate' ||
                (_shippingZoneList[i].name ?? '') == 'Flat Rate') {
              fetchShippingMethod(id: _shippingZoneList[i].id.toString());
            }
          }
        }
      }
    } else {
      //Dialog dismiss
      ApiChecker.checkApi(response);
    }
  }

  ///get single order data
  Future<void> fetchShippingMethod({required String id}) async {
    _isLoading = true;
    update();

    final response = await orders.getShippingMethod(id: id);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ShippingMethodList> posts = body
          .map(
            (dynamic item) => ShippingMethodList.fromJson(item),
          )
          .toList();
      log(response.body);
      if (body.isEmpty) {
        _isLoading = false;
        update();
      } else {
        log('=================>> add log');
        _shippingMethodList.addAll(posts);
        _isLoading = false;
        update();
        updateShippingFee();
      }
    } else {
      //Dialog dismiss
      ApiChecker.checkApi(response);
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  void changeProductExpanded() {
    _productExpanded = !_productExpanded;
    update();
  }

  void changePaymentExpanded() {
    _paymentExpanded = !_paymentExpanded;
    update();
  }

  void changeAddressExpanded() {
    _addressExpanded = !_addressExpanded;
    update();
  }

  void updatePayStackCalled() {
    _payStackCalled = true;
    update();
  }

  void changeCountryValue(String value) {
    _countryValue = value;
    update();
  }

  void changeStateValue(String value) {
    _stateValue = value;
    update();
  }

  void changeCitiesValue(String value) {
    _cityValue = value;
    update();
  }

  void updatePaymentMethod({
    required String id,
    required title,
  }) {
    _paymentMethod = id;
    _paymentMethodTitle = title;
    update();
  }

  void updateShippingFee() {
    int value = 0;
    if (_shippingMethodList.isNotEmpty) {
      for (int i = 0; i < _shippingMethodList.length; i++) {
        if ((_shippingMethodList[i].methodTitle ?? '') == 'Flat rate' ||
            (_shippingMethodList[i].methodTitle ?? '') == 'Flat Rate') {
          value =
              int.parse(_shippingMethodList[i].settings?.cost?.value ?? '0');
          log('=================>> update shipping' +
              _shippingMethodList[i].methodId.toString());
          _shippingFee = value;
          update();
        } else {
          _shippingFee = 0;
          update();
        }
      }
    }
  }

  void updateDiscountPrice(int value, String code) {
    _discountPrice = value;
    _isDiscount = true;
    _couponCode = code;
    update();
  }

  void deleteDiscountPrice() async {
    _discountPrice = 0;
    _isDiscount = false;
    _couponCode = '';
    //init razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //init pay payment gateway
    //  configureApp();
    update();
  }

  getUserData() {
    _nameController.text = authRepo.getUserName();
    update();
  }

  List<ShippingLines> shippingLineData({
    String methodId = 'flat_rate',
    String methodTitle = 'flat_rate',
  }) {
    List<ShippingLines> data = [];
    if (_shippingMethodList.isNotEmpty) {
      for (int i = 0; i < _shippingMethodList.length; i++) {
        if (((_shippingMethodList[i].methodTitle ?? '') == 'Flat rate') ||
            ((_shippingMethodList[i].methodTitle ?? '') == 'Flat Rate')) {
          data.add(
            ShippingLines(
              methodId: _shippingMethodList[i].methodId ?? '',
              methodTitle: _shippingMethodList[i].methodTitle ?? '',
              total: _shippingMethodList[i].settings?.cost?.value ?? '',
            ),
          );
          log('=================>> add shipping' +
              _shippingMethodList[i].methodId.toString());
        } else {
          data.add(
            ShippingLines(
              methodId: methodId,
              methodTitle: methodTitle,
              total: '0',
            ),
          );
        }
      }
    }
    return data;
  }

  List<CouponLines> couponLineData() {
    List<CouponLines> data = [];
    data.add(CouponLines(
      code: _couponCode,
    ));

    return data;
  }

  void productData({
    required List<CartModel> cartData,
  }) {
    itemData.clear();

    for (int i = 0; i < cartData.length; i++) {
      itemData.add(LineItems(
        productId: cartData[i].id ?? 0,
        quantity: cartData[i].quantity ?? 0,
      ));
      update();
    }
  }

  List<Map<String, String>> paypalProductItem(List<LineItems> list) {
    List<Map<String, String>> data = [];
    for (int i = 0; i < list.length; i++) {
      data.add({
        "name": 'A demo product',
        "quantity": (list[i].quantity ?? 0).toString(),
        "price": '10.12',
        "currency": "MAD"
      });
    }

    return data;
  }

  void showNonce(BraintreePaymentMethodNonce nonce, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            const SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            const SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
        ),
      ),
    );
  }

  //SSL commerz
  Future<void> sslCommercePayment({
    required BuildContext context,
    required String amount,
    required CreateOrder order,
  }) async {
    if (kStoreId.isEmpty) {
      showCustomSnackBar('Your ssl commerz store id hare');
      return;
    } else if (kStorePassword.isEmpty) {
      showCustomSnackBar('Your ssl commerz store password hare');
      return;
    }
    Sslcommerz sslCommerce = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Women's fashion",
        ipn_url: "www.ipnurl.com",
        sdkType: SSLCSdkType.LIVE,
        store_id: kStoreId,
        store_passwd: kStorePassword,
        total_amount: 150.00,
        tran_id: DateTime.now().microsecondsSinceEpoch.toString(),
      ),
    );
    sslCommerce
        .addEMITransactionInitializer(
          sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
            emi_options: 1,
            emi_max_list_options: 3,
            emi_selected_inst: 2,
          ),
        )
        .addShipmentInfoInitializer(
          sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
            shipmentMethod: "yes",
            numOfItems: 10,
            shipmentDetails: ShipmentDetails(
              shipAddress1: order.shipping?.address1 ?? '',
              shipCity: order.shipping?.city ?? '',
              shipCountry: order.shipping?.country ?? '',
              shipName: 'your ship name',
              shipPostCode: order.shipping?.postcode ?? '',
            ),
          ),
        )
        .addCustomerInfoInitializer(
          customerInfoInitializer: SSLCCustomerInfoInitializer(
            customerName:
                '${order.billing?.firstName ?? ''} ${order.billing?.lastName ?? ''}',
            customerEmail: order.billing?.email ?? '',
            customerAddress1: order.billing?.address1 ?? '',
            customerState: order.billing?.state ?? '',
            customerCity: order.billing?.city ?? '',
            customerPostCode: order.billing?.postcode ?? '',
            customerCountry: order.billing?.country ?? '',
            customerPhone: order.billing?.phone ?? '',
          ),
        )
        .addProductInitializer(
          sslcProductInitializer: SSLCProductInitializer(
            productName: "Gadgets",
            productCategory: "Widgets",
            general: General(
              general: "General Purpose",
              productProfile: "Product Profile",
            ),
          ),
        )
        .addAdditionalInitializer(
          sslcAdditionalInitializer: SSLCAdditionalInitializer(
            valueA: "app",
            valueB: "value b",
            valueC: "value c",
            valueD: "value d",
          ),
        );
    var result = await sslCommerce.payNow();
    log('ssl Result ====>' + result.toString());
    if (result is PlatformException) {
      log("the response is: " +
          result.message.toString() +
          " code: " +
          result.code.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message ?? ''),
        ),
      );
    } else {
      SSLCTransactionInfoModel model = result;
      log("ssL json" + model.toJson().toString());
      if (model.aPIConnect == 'DONE' && model.status == 'VALID') {
        Get.off(() => const DashBoardScreen());
        Get.find<CartController>().getAllCartList();
        showCustomSnackBar('Payment success', isError: false);
      } else {
        showCustomSnackBar('Payment Failed');
      }
    }
  }

  ///razorpay
  void razorPayOpenCheckout({
    required BuildContext context,
    required String amount,
    required CreateOrder order,
  }) async {
    if (kRazorpayKeyId.isEmpty) {
      showCustomSnackBar('Your razorpay key id hare');
      return;
    }
    var options = {
      'key': kRazorpayKeyId,
      'amount': int.parse(amount),
      'name':
          '${order.billing?.firstName ?? ''} ${order.billing?.lastName ?? ''}',
      'description': 'RTX 3090ti',
      'retry': {
        'enabled': true,
        'max_count': 1,
      },
      'send_sms_hash': true,
      'prefill': {
        'contact': order.billing?.phone ?? '',
        'email': order.billing?.email ?? '',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.off(() => const DashBoardScreen());
    Get.find<CartController>().getAllCartList();
    showCustomSnackBar("SUCCESS: " + response.paymentId!, isError: false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showCustomSnackBar(
      "ERROR: " + response.code.toString() + " - " + response.message!,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showCustomSnackBar(
      "EXTERNAL_WALLET: " + response.walletName!,
    );
  }

  ///end razor pay

  ///Start Paytm
  Future<void> startPaytmTransaction({
    required BuildContext context,
    required String amount,
    required String orderId,
  }) async {
    if (kPaytmMerchantId.isEmpty) {
      showCustomSnackBar('Your paytm merchant id hare');
      return;
    }
    String result = '';
    try {
      var response = AllInOneSdk.startTransaction(
          kPaytmMerchantId,
          orderId,
          amount,
          DateTime.now().microsecondsSinceEpoch.toString(),
          'https://securegw-stage.paytm.in/theia/paytmCallback?$orderId',
          true,
          false,
          false);
      response.then((value) {
        log(value.toString());
        result = value.toString();
        Get.off(() => const DashBoardScreen());
        Get.find<CartController>().getAllCartList();
        showCustomSnackBar('Payment success', isError: false);
      }).catchError((onError) {
        if (onError is PlatformException) {
          result =
              onError.message.toString() + " \n  " + onError.details.toString();
          showCustomSnackBar(result);
        } else {
          String result = onError.toString();
          showCustomSnackBar(result);
        }
      });
    } catch (err) {
      String result = err.toString();
      showCustomSnackBar(result);
    }

    log(result);
  }
}
