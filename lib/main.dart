import 'dart:math';

import 'package:airbnb_book/book.dart';
import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const AnimatedBookChallenge());
}

class AnimatedBookChallenge extends StatelessWidget {
  const AnimatedBookChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 800,
          height: 500,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return Positioned(
                    left: -200 + _controller.value * 200,
                    top: 150 - _controller.value * 150,
                    bottom: 0,
                    child: Transform.scale(
                      scale: Tween<double>(begin: .2, end: 1)
                          .chain(CurveTween(curve: Curves.easeInOut))
                          .evaluate(_controller),
                      child: Book(
                        openAngleRadians: Tween<double>(begin: 40, end: 180)
                                .chain(CurveTween(curve: Curves.easeInOut))
                                .evaluate(_controller) *
                            pi /
                            180,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: const Text('Toggle open'),
        ),
      ],
    );
  }
}

class MyPaint extends CustomPainter {
  final openAngle = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    final path = Path();
    path
      ..moveTo(0, -250)
      ..lineTo(400, -250)
      ..lineTo(400, 250)
      ..lineTo(0, 250);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
