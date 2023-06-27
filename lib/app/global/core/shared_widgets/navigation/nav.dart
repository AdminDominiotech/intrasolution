import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Nav {
  static Future back<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) async {
    return Navigator.pop<Object?>(context, result);
  }

  static Future<T?> go<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).push(
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          if (animation.status == AnimationStatus.reverse) {
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          }
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: animation.drive(tween),
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future<T?> replace<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder<T>(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease));

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          if (animation.status == AnimationStatus.reverse) {
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          }
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: animation.drive(tween),
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future<T?> modal<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return showCupertinoModalPopup<T?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      builder: (BuildContext ctx) {
        return page;
      },
    );
  }
}
