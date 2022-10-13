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
      duration: Duration(seconds: 4),
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
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: widget.child,
            );

            return Container(
              width: 200,
              height: 200,
              color: Colors.amber.shade400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/shopping2.jpg'),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(height: 64),
                  Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
