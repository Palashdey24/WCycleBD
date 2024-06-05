import 'package:flutter/material.dart';

  class SignInOvalPathBottom extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



  // Layer 1

  Paint paintFill0 = Paint()
  ..color = const Color.fromARGB(255, 255, 255, 255)
  ..style = PaintingStyle.fill
  ..strokeWidth = size.width*0.00
  ..strokeCap = StrokeCap.butt
  ..strokeJoin = StrokeJoin.miter;


  Path path_0 = Path();
  path_0.moveTo(size.width*0.9981818,size.height*0.0016667);
  path_0.lineTo(0,size.height*0.0050000);
  path_0.lineTo(size.width*0.0009091,size.height*1.0016667);
  path_0.lineTo(size.width*0.2272727,size.height*1.0033333);
  path_0.lineTo(size.width*0.3330818,size.height*1.2575000);
  path_0.lineTo(size.width*0.2274636,size.height*0.9973833);
  path_0.quadraticBezierTo(size.width*0.2537455,size.height*0.7316000,size.width*0.3863818,size.height*0.6794333);
  path_0.cubicTo(size.width*0.4180273,size.height*0.6537333,size.width*0.5093545,size.height*0.6590167,size.width*0.5503455,size.height*0.6694000);
  path_0.cubicTo(size.width*0.5168545,size.height*0.6553833,size.width*0.6152818,size.height*0.6809000,size.width*0.6360909,size.height*0.6961167);
  path_0.cubicTo(size.width*0.6460091,size.height*0.7319833,size.width*0.6901545,size.height*0.7147500,size.width*0.7022636,size.height*0.7679333);
  path_0.quadraticBezierTo(size.width*0.7075909,size.height*0.8086500,size.width*0.7481182,size.height*0.8696167);
  path_0.lineTo(size.width*0.7725818,size.height*0.9470167);
  path_0.lineTo(size.width*0.7844727,size.height*1.0037167);
  path_0.lineTo(size.width*0.8186182,size.height*1.0032500);
  path_0.lineTo(size.width*0.9171364,size.height*1.0023333);
  path_0.lineTo(size.width*0.9954545,size.height*0.9966667);
  path_0.lineTo(size.width*1.0018182,size.height*0.1916667);
  path_0.lineTo(size.width*0.9981818,size.height*0.0016667);
  path_0.close();

  canvas.drawPath(path_0, paintFill0);


  // Layer 1

  Paint paintStroke0 = Paint()
  ..color = const Color.fromARGB(255, 33, 150, 243)
  ..style = PaintingStyle.stroke
  ..strokeWidth = size.width*0.00
  ..strokeCap = StrokeCap.butt
  ..strokeJoin = StrokeJoin.miter;



  canvas.drawPath(path_0, paintStroke0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
  return true;
  }

  }
