import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';
import '../../../../main.dart';
import 'intro_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [];
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    splashData = [
      {
        "text": "Order Your Goods",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark1 : Images.intro1
      },
      {
        "text": "Pay Via Card",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark2 : Images.intro2
      },
      {
        "text": "Quick Delivery",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark3 : Images.intro3
      },
    ];
    return Scaffold(
      backgroundColor: Get.isDarkMode ? kBgDarkColor : kWhiteColor,
      appBar: AppBar(
        leading: currentPage == 0
            ? null
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                ),
                onPressed: () {
                  controller.previousPage(
                      duration: const Duration(microseconds: 300),
                      curve: Curves.decelerate);
                },
              ),
        actions: [
          InkWell(
            onTap: () async {
              intro = await SharedPreferences.getInstance();
              intro.setBool('intro', true);
              Get.offAll(
                const DashBoardScreen(),
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Skip',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 16, height: 1.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => IntroContent(
                image: splashData[index]["image"],
                text: splashData[index]['text'],
                decs: splashData[index]['decs'],
                index: currentPage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (currentPage != splashData.length - 1) {
                            // setState(() {
                            //   ++currentPage;
                            // });
                            controller.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.decelerate);
                          } else {
                            intro = await SharedPreferences.getInstance();
                            intro.setBool('intro', true);
                            Get.offAll(
                              const DashBoardScreen(),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            currentPage == splashData.length - 1
                                ? 'Finish'
                                : 'Next',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontSize: 16, height: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: currentPage == index ? 10 : 7,
      width: currentPage == index ? 10 : 7,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kBlackColor2,
        shape: BoxShape.circle,
      ),
    );
  }
}
