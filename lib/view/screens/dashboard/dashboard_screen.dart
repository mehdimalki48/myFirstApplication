import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/controllers/favorite_controller.dart';
import 'package:woogoods/view/screens/account/account_screen.dart';
import 'package:woogoods/view/screens/cart/cart_screen.dart';
import 'package:woogoods/view/screens/category/categories_screen.dart';
import 'package:woogoods/view/screens/home/home_screen.dart';
import 'package:woogoods/view/screens/review/review_home_screen.dart';
import 'package:woogoods/view/widgets/custom_alert_dialog.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = 'dashboard';
  const DashBoardScreen({Key? key, this.index = 0}) : super(key: key);
  final int? index;

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<DashBoardScreen> {
  var pageController = PageController();
  late int _selectedIndex;
  List<Widget> _screen = [];
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.index!;
    _screen = [
      const HomeScreen(),
      const CategoriesScreen(),
      const ReviewHomeScreen(),
      const CartListScreen(),
      const AccountScreen(),
    ];

    super.initState();
  }

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<FavoriteController>().getFavoriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return _onBackPressed();
        } else {
          setState(() {
            _selectedIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _onPageChanged,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.home,
                color: _selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Home".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.category,
                color: _selectedIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Category".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.review,
                color: _selectedIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Review".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.cart,
                color: _selectedIndex == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Cart".tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.account,
                color: _selectedIndex == 4
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              label: "Account".tr,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return CustomAlertDialog()
        .customAlert(
          context: context,
          title: 'Are you sure?',
          body: 'Do you want to exit an app!',
          color: kPrimaryColor,
          onPress: () {
            SystemNavigator.pop();
          },
        )
        .show()
        .then((value) => value as bool);
  }
}
