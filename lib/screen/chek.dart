import 'dart:math';

import 'package:flutter/material.dart';

class Chek extends StatefulWidget {
  const Chek({super.key});

  @override
  State<Chek> createState() => _ChekState();
}

class _ChekState extends State<Chek> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController)
      ..addStatusListener(
        (status) {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          _status = status;
        },
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(2, 1, 0.0015)
                    ..rotateY(pi * _animation.value),
                  child: child,
                );
              },
              child: Card(
                color: Colors.white,
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.blue,
                        width: 240,
                        height: 240,
                      )
                    : Container(
                        color: Colors.orange,
                        width: 240,
                        height: 240,
                      ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_status == AnimationStatus.dismissed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                },
                child: const Text("data"))
          ],
        ),
      ),
    );
  }
}
