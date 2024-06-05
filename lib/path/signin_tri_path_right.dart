import 'package:flutter/material.dart';

class SignInTriPathRight extends  CustomClipper<Path>{
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path=Path();

    path.lineTo(size.width , 0);
    path.lineTo(size.width, size.height);

    path.close();



    return path;
  }

  @override
  bool shouldReclip( CustomClipper<dynamic> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}