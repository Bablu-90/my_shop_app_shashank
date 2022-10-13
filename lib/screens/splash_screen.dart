import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((_) => {Get.to(() => OnBoardingScreen())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ecommerce.jpg')),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 64),
            const Spacer(),
            const Text(
              'My Shop',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
