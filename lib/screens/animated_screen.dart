import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedScreenWidget extends StatefulWidget {
  final Widget child;

  const AnimatedScreenWidget({super.key, required this.child});

  @override
  State<AnimatedScreenWidget> createState() => _AnimatedScreenWidgetState();
}

class _AnimatedScreenWidgetState extends State<AnimatedScreenWidget>
    with TickerProviderStateMixin {
  final RxBool _isLoading = false.obs;
  late AnimationController _controller;

  @override
  void initState() {
    _isLoading.value = true;
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _isLoading.value = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              /*return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: widget.child,
              );*/

              return Container(
                width: 200,
                height: 200,
                color: Colors.amber.shade400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/shopping2.jpg'),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    const SizedBox(height: 64),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
