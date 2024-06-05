import 'package:flutter/material.dart';

class SignInTriPathLeft extends  CustomClipper<Path>{
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path=Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, 50);
    path.lineTo(size.width, 0);
    path.close();



    return path;
  }

  @override
  bool shouldReclip( CustomClipper<dynamic> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
