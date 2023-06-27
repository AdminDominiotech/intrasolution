import 'package:flutter/cupertino.dart';

/// Created by JeanRoldanDev

class RightToLeftPageRoute extends PageRouteBuilder<Widget> {
  RightToLeftPageRoute({
    required this.newPage,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (_, animation, __) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: newPage,
          ),
          transitionDuration: duration,
        );

  final Widget newPage;
}

class FadePageRoute extends PageRouteBuilder<Widget> {
  FadePageRoute({
    required this.newPage,
    Duration duration = const Duration(milliseconds: 400),
  }) : super(
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: newPage,
          ),
          transitionDuration: duration,
        );

  final Widget newPage;
}
