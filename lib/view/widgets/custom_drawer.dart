import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: kPrimaryColor),
            accountName: Text(
              prefs.containsKey('token')
                  ? (prefs.getString('name') != 'null'
                      ? prefs.getString('name')!
                      : prefs.getString('phone')!)
                  : 'Guest',
            ),
            accountEmail: prefs.containsKey('token')
                ? Text(
                    prefs.getString('email') != null
                        ? prefs.getString('email')!
                        : prefs.getString('phone')!,
                  )
                : GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, LogIn.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Login'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.login,
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                  ),
            currentAccountPicture: Container(
              alignment: Alignment.center,
              width: 100.0,
              height: 100.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(kImageDir + 'logo.png'),
                  )),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.phone,
              color: kPrimaryColor,
            ),
            title: Text(
              'Contact Us'.tr,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.language,
              color: kPrimaryColor,
            ),
            title: Text(
              'Languages'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
