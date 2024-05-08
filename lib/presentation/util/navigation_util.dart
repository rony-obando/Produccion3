import 'package:flutter/material.dart';

class navigatioUtil {
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(createNoAnimationRoute(screen));
  }

  static Route createNoAnimationRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration
          .zero, // Especifica una duración de cero para que no haya demora
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child; // Devuelve directamente el child sin aplicar animaciones
      },
    );
  }
}
