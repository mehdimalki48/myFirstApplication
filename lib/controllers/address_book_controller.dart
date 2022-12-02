import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/helper/sqlite_db_helper.dart';
import 'package:woogoods/models/response/address_book.dart';

class AddressBookController extends GetxController {
  //Init Database
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  //Init model
  final List<AddressBook> _addressList = [];
  final List<AddressBook> _unSelectedList = [];
  AddressBook? _selectedItemAddress;
  AddressBook? _selectCheckoutAddress;
  //Init
  bool _isLoading = false;
  bool _isCheckout = false;
  bool _selectedAddress = false;
  String _selectLabel = "Home"; //Home and Office
  String _selectionCountryCode = "+880";
  String _countryValue = "";
  String _stateValue = "";
  String _cityValue = "";
  final String _address = "";
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  ///Encapsulation
  List<AddressBook> get addressList => _addressList;
  List<AddressBook> get unSelectedList => _unSelectedList;

  AddressBook? get selectedItemAddress => _selectedItemAddress;
  AddressBook? get selectCheckoutAddress => _selectCheckoutAddress;

  bool get isLoading => _isLoading;
  bool get isCheckout => _isCheckout;

  bool get selectedAddress => _selectedAddress;

  String get selectLabel => _selectLabel;

  String get selectionCountryCode => _selectionCountryCode;

  String get countryValue => _countryValue;

  String get stateValue => _stateValue;

  String get cityValue => _cityValue;

  String get address => _address;

  TextEditingController get fNameController => _fNameController;

  TextEditingController get lNameController => _lNameController;

  TextEditingController get phoneController => _phoneController;

  TextEditingController get addressController => _addressController;

  TextEditingController get postCodeController => _postCodeController;

  ///Address add
  void addToAddress(
    AddressBook addressBook,
  ) async {
    //for adding existing items to the cart and increase quantity
    var isExist =
        _addressList.indexWhere((element) => element.id == addressBook.id);
    log('Exist : $isExist');

    if (isExist >= 0) {
      if ((addressBook.isSelect ?? 0) == 0) {
        log('is selected');
        updateAddress(
          addressBook.id ?? 0,
          addressBook,
        );
      } else {
        log('don\'t selected');
        for (int i = 0; i < _addressList.length; i++) {
          if ((_addressList[i].id ?? 0) != (addressBook.id ?? 0)) {
            updateIsSelectAddress(
              _addressList[i].id ?? 0,
              0,
            );
          } else {
            updateAddress(
              addressBook.id ?? 0,
              addressBook,
            );
          }
        }
      }

      Get.back();
      showCustomSnackBar('Update from cart Successfully!', isError: false);
    } else {
      if ((addressBook.isSelect ?? 0) == 0) {
        log('don\'t selected');
        _databaseHelper.insertAddress(addressBook);
        var result = await _databaseHelper.getAllAddress();
        if (result.isNotEmpty) {
          _addressList.assignAll(result);
          getAllAddressList();
        }
      } else {
        log('is selected');
        if (_addressList.isNotEmpty) {
          for (int i = 0; i < _addressList.length; i++) {
            if ((_addressList[i].id ?? 0) != (addressBook.id ?? 0)) {
              updateIsSelectAddress(
                _addressList[i].id ?? 0,
                0,
              );
            } else {
              updateAddress(
                addressBook.id ?? 0,
                addressBook,
              );
            }
          }
        }
        _databaseHelper.insertAddress(addressBook);
        var result = await _databaseHelper.getAllAddress();
        if (result.isNotEmpty) {
          _addressList.assignAll(result);
          getAllAddressList();
        }
      }

      Get.back();
      showCustomSnackBar('Added to Address Book Successfully!', isError: false);
    }
  }

  ///cart remove from item
  Future<void> removeFromAddress(int id) async {
    try {
      _isLoading = true;
      await _databaseHelper.deleteAddress(id);
      showCustomSnackBar('Delete from Address Book Successfully!',
          isError: false);
      getAllAddressList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///Get  all cart
  void getAllAddressList() async {
    try {
      _isLoading = true;

      var product = await _databaseHelper.getAllAddress();
      _addressList.assignAll(product);
      _unSelectedList.clear();
      update();
      changeIsCheckout(false);
      updateSelectedItem();
      for (int i = 0; i < product.length; i++) {
        if ((product[i].isSelect ?? 0) == 0) {
          _unSelectedList.add(
            product[i],
          );
          update();
        }
      }

      var productList = jsonEncode(_addressList.isNotEmpty ? _addressList : '');
      log(productList);
    } finally {
      _isLoading = false;
      update();
    }
  }

  void updateAddress(
    int id,
    AddressBook model,
  ) async {
    try {
      _isLoading = true;
      await _databaseHelper.updateAddress(
        id,
        model,
      );
      getAllAddressList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  void updateIsSelectAddress(
    int id,
    int select,
  ) async {
    try {
      _isLoading = true;
      log(select.toString() + 'is select');
      await _databaseHelper.updateIsSelectAddress(
        id,
        select,
      );
      getAllAddressList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///Check already added
  bool isAlreadyAdd(int id) {
    var isExist = _addressList.indexWhere((element) => element.id == id);
    log('Exist : $isExist');
    if (isExist >= 0) {
      return true;
    } else {
      return false;
    }
  }

  void emptyCart() async {
    try {
      _isLoading = false;
      await _databaseHelper.emptyAddressList();
      getAllAddressList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///new address and edit check is selected address
  void changeSelectAddress() {
    _selectedAddress = !_selectedAddress;
    update();
  }

  ///if checkout address is check
  void changeIsCheckout(bool isCheckout) {
    _isCheckout = isCheckout;
    update();
  }

  ///checkout selected address
  void selectedIsCheckoutAddress(AddressBook addressBook) {
    _selectCheckoutAddress = null;
    _selectCheckoutAddress = addressBook;
    update();
    changeIsCheckout(true);
  }

  ///change Label as from address screen
  void changeLabelAs(String value) {
    log(value);
    _selectLabel = value;
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

  void changeCountryCodeValue(String value) {
    _selectionCountryCode = value;
    update();
  }

  ///SQLite database check is selected item.
  void updateSelectedItem() {
    _selectedItemAddress = null;
    if (_addressList.isNotEmpty) {
      for (int i = 0; i < _addressList.length; i++) {
        if ((_addressList[i].isSelect ?? 0) == 1) {
          _selectedItemAddress = _addressList[i];
          update();
          log('se');
        }
      }
    }
  }

  ///edit address screen set filed
  void setSelectedAddress(AddressBook address) async {
    try {
      _isLoading = true;
      _fNameController.text = address.firstName ?? '';
      _lNameController.text = address.lastName ?? '';
      _phoneController.text = address.phone ?? '';
      _postCodeController.text = address.postcode ?? '';
      _addressController.text = address.address ?? '';
      _countryValue = address.country ?? '';
      _stateValue = address.state ?? '';
      _cityValue = address.city ?? '';
      _selectLabel = address.labelAs ?? '';
      _selectionCountryCode = address.countyCode ?? '';
      _selectedAddress = (address.isSelect ?? 0) == 1 ? true : false;
      update();
    } finally {
      _isLoading = false;
      update();
    }
  }

  ///new address screen clear filed
  void clearAddress() async {
    try {
      _isLoading = true;
      _fNameController.text = '';
      _lNameController.text = '';
      _phoneController.text = '';
      _postCodeController.text = '';
      _addressController.text = '';
      _countryValue = '';
      _stateValue = '';
      _cityValue = '';
      _selectLabel = 'Home';
      _selectionCountryCode = '+880';
      _selectedAddress = false;
      update();
    } finally {
      _isLoading = false;
      update();
    }
  }
}
