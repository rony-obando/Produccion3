import 'package:flutter/material.dart';

Route createRoute(Widget SecondPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}