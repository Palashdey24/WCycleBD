import 'package:flutter/material.dart';

class MyPages extends StatefulWidget {
  const MyPages({super.key});

  @override
  State<MyPages> createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> {
  late PageController _horizontalController;
  final double itemWidth = 100.0;
  final double viewportFraction = 0.7;

  @override
  void initState() {
    _horizontalController =
        PageController(initialPage: 0, viewportFraction: viewportFraction);
    super.initState();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = viewportFraction * MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _horizontalController,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            margin: const EdgeInsets.only(right: 8),
            color: Colors.grey,
            child: Center(child: Text('$index')),
          );
        },
      ),
    );
  }
}
