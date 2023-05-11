import 'dart:math';

import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  const Book({
    super.key,
    required this.openAngleRadians,
  });

  final double openAngleRadians;

  @override
  Widget build(BuildContext context) {
    final appliedAngleRadians = pi - openAngleRadians;
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: 400,
          height: 500,
          decoration: BoxDecoration(
            color: ColorTween(
              begin: Colors.grey.shade200,
              end: Colors.white,
            ).transform(openAngleRadians / pi),
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(20),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..rotateY(appliedAngleRadians)
            ..setEntry(3, 0, sin(appliedAngleRadians) * .0005),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 400,
            height: 500,
            child: Material(
              animationDuration: Duration.zero,
              elevation: max(0, 35 * (1 - openAngleRadians / (pi / 2))),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
