import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:woogoods/constants/colors_data.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SpinKitFadingCircle(
        color: kPrimaryColor,
        size: 50.0,
      ),
    );
  }
}
