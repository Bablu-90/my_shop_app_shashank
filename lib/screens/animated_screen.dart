import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedScreenWidget extends StatefulWidget {
  final Widget child;

  const AnimatedScreenWidget({super.key, required this.child});

  @override
  State<AnimatedScreenWidget> createState() => _AnimatedScreenWidgetState();
}

class _AnimatedScreenWidgetState extends State<AnimatedScreenWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent.shade100,
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, Widget? child) {
              Transform.rotate(
                  angle: _controller.value * 2 * math.pi, child: child);
              /*return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: widget.child,
              );*/
              return Container(
                width: 200,
                height: 200,
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/laptop.png"),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 64),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
