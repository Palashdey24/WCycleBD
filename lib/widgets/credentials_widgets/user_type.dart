import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

final fontHelper = FontHelper();

class UserType extends StatelessWidget {
  const UserType({
    super.key,
    required this.userText,
    this.quarterTurns,
    required this.onTap,
    this.rotateY,
    required this.individual,
  });
  final String userText;
  final int? quarterTurns;
  final void Function() onTap;
  final double? rotateY;
  final bool individual;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: RotatedBox(
        quarterTurns: quarterTurns ?? 0,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(individual ? rotateY ?? -1 + 120 * pi / 180 : 0),
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(25),
              ),
              child: AnimatedContainer(
                height: 90,
                color: individual ? Colors.black26 : Colors.black,
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: quarterTurns ?? 0,
                      child: Text(
                        userText.toUpperCase(),
                        style: fontHelper
                            .bodySmall(context)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
