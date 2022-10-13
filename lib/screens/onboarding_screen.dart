import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:my_shop_app/screens/animated_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        skipCallback: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AnimatedScreenWidget(
              child: Container(),
            );
          }));
        },
        finishCallback: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductsOverviewScreen();
          }));
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: Colors.greenAccent.shade200,
        imageAssetPath: 'assets/images/laptop.png',
        title: 'Shop Screen ',
        body: 'Share your ideas with the team',
        doAnimateImage: true),
    PageModel(
        color: Colors.deepOrange.shade200,
        imageAssetPath: 'assets/images/online 1.jpg',
        title: 'Shop Screen ',
        body: 'See the increase in productivity & output',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/images/shopping 2.jpg',
        title: 'Shop Screen ',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Image.asset('assets/images/ecommerce.jpg',
              width: 300.0, height: 300.0),
        ),
        color: Colors.lightBlue.shade200,
        doAnimateChild: true)
  ];
}
