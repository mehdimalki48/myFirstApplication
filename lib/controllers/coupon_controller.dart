import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/date_converter.dart';
import 'package:woogoods/models/response/coupon_list_rp.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/auth_repo.dart';
import 'package:woogoods/services/repository/coupon_repo.dart';

class CouponController extends GetxController {
  final CouponRepo couponRepo;
  final AuthRepo authRepo;

  CouponController({required this.couponRepo, required this.authRepo});

  //Init model
  List<CouponListRp> _couponList = [];
  List<CouponListRp> _useCouponList = [];

  //Init
  bool _isLoading = false;
  late int _popularPageSize;
  List<String> _offsetList = [];
  int _offset = 1;

  ///Encapsulation
  List<CouponListRp> get couponList => _couponList;

  List<CouponListRp> get useCouponList => _useCouponList;

  bool get isLoading => _isLoading;

  int get popularPageSize => _popularPageSize;

  int get offset => _offset;

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> fetchCouponList(String offset, bool reload,
      {String search = ''}) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if (reload) {
        _couponList = [];
        _useCouponList = [];
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await couponRepo.getCouponList(
        offset,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          _couponList = [];
          _useCouponList = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<CouponListRp> posts = body
            .map(
              (dynamic item) => CouponListRp.fromJson(item),
            )
            .toList();
        log(response.body);

        //List<CouponListRp> useCouponList = [];
        if (posts.isNotEmpty) {
          for (int i = 0; i < posts.length; i++) {
            var isExist = posts[i]
                .usedBy
                ?.indexWhere((element) => element == authRepo.getUserId());

            if (isExist! >= 0) {
              _useCouponList.add(posts[i]);
              //_useCouponList.addAll(_useCouponList);
            }
          }
        }

        if (body.isEmpty) {
          _isLoading = false;
          update();
          showCustomSnackBar('No more coupons');
        } else {
          _couponList.addAll(posts);
          _popularPageSize = posts.length;
          _isLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  Future<void> applyCoupon(BuildContext context,
      {required String code,
      required int totalPrice,
      required int quantity}) async {
    _isLoading = true;
    update();
    final response =
        await couponRepo.getCouponList('1', code: code, perPage: '2');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CouponListRp> posts = body
          .map(
            (dynamic item) => CouponListRp.fromJson(item),
          )
          .toList();
      log(response.body);

      if (body.isEmpty) {
        _isLoading = false;
        //Dialog dismiss
        Navigator.of(context).pop();
        update();
        showCustomSnackBar('Voucher code is invalid!');
      } else {
        List<CouponListRp> applyCouponList = posts;
        if (applyCouponList.isNotEmpty) {
          if (applyCouponList[0].dateExpires == null) {
            if (applyCouponList[0].usageLimitPerUser == null) {
              applyCouponUpdateDiscount(
                  applyCouponList[0], totalPrice, quantity, code);
              log('unlimited user');
            } else {
              log('limit user');
              if (getUserUseCount(applyCouponList[0]) <=
                  applyCouponList[0].usageLimitPerUser!) {
                applyCouponUpdateDiscount(
                    applyCouponList[0], totalPrice, quantity, code);
              } else {
                showCustomSnackBar('Limit expired this voucher');
              }
            }
          } else {
            final now = DateTime.now();
            // final expirationDate = DateTime(2021, 1, 10);
            final expirationDate = DateConverter.convertStringToDateFormat2(
                applyCouponList[0].dateExpires!);
            final bool isExpired = expirationDate.isBefore(now);

            if (isExpired) {
              showCustomSnackBar('Date expired this voucher!');
            } else {
              if (applyCouponList[0].usageLimitPerUser == null) {
                applyCouponUpdateDiscount(
                    applyCouponList[0], totalPrice, quantity, code);
                log('unlimited user');
              } else {
                log('limit user');
                if (getUserUseCount(applyCouponList[0]) <=
                    applyCouponList[0].usageLimitPerUser!) {
                  applyCouponUpdateDiscount(
                      applyCouponList[0], totalPrice, quantity, code);
                } else {
                  showCustomSnackBar('Limit expired this voucher');
                }
              }
            }
          }

          //Dialog dismiss
          Navigator.of(context).pop();
        } else {
          showCustomSnackBar('Voucher code is invalid!');
          //Dialog dismiss
          Navigator.of(context).pop();
        }
        _isLoading = false;
        update();
      }
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  int getUserUseCount(CouponListRp couponData) {
    int count = 0;
    if (couponData.usedBy!.isNotEmpty) {
      count = 0;
      for (int i = 0; i < couponData.usedBy!.length; i++) {
        var isExist = couponData.usedBy!
            .indexWhere((element) => element == authRepo.getUserId());

        if (isExist >= 0) {
          ++count;
        }
      }
      return count;
    } else {
      return 0;
    }
  }

  void applyCouponUpdateDiscount(
      CouponListRp couponData, int totalPrice, int quantity, String code) {
    if (couponData.discountType == 'percent') {
      double discount = double.parse(
            couponData.amount.toString(),
          ) *
          totalPrice /
          100;
      log(discount.toString());
      log('percent');
      // Get.find<CheckoutController>()
      //     .updateDiscountPrice(discount.toInt(), code);
    } else if (couponData.discountType == 'fixed_cart') {
      /*int discount = double.parse(
        couponData.amount.toString(),
      ).toInt();
      Get.find<CheckoutController>().updateDiscountPrice(discount, code);*/
    } else if (couponData.discountType == 'fixed_product') {
      /*     int discount = (double.parse(
            couponData.amount.toString(),
          ).toInt() *
          quantity);
      Get.find<CheckoutController>().updateDiscountPrice(discount, code);*/
    }
  }
}
