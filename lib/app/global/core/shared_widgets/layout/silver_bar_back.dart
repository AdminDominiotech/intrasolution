import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe2biz/app/global/core/core.dart';

class SliverBarBack extends SliverPersistentHeaderDelegate {
  const SliverBarBack({
    required this.maxExtended,
    required this.minExtended,
    required this.size,
    this.title,
    this.label,
    this.onFloatingTap,
    this.showFloating = true,
    this.onBack,
    this.showAction = false,
    this.onTapAction,
  });

  final double maxExtended;
  final double minExtended;
  final Size size;
  final String? title;
  final String? label;
  final VoidCallback? onBack;
  final VoidCallback? onFloatingTap;
  final bool showAction;
  final bool showFloating;
  final VoidCallback? onTapAction;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxExtended;
    final fixrotation = pow(percent, 1.5);
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundSliver(),
          ButtonBack(
            size: size,
            percent: percent,
            title: title,
            onTap: onBack,
            showAction: showAction,
            onTapAction: onTapAction,
          ),
          SpacingFlexible(
            size: size,
            percent: percent,
            title: label,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: -size.width * fixrotation.clamp(0, 0.35),
            child: SizedBox(
              height: size.height * 0.05,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: CutRectangle(),
                  ),
                ],
              ),
            ),
          ),
          if (showFloating)
            BtnCircular(
              size: size,
              percent: percent,
              icon: const Icon(
                FontAwesomeIcons.plus,
              ),
              onTap: onFloatingTap,
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class CutRectangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = S2BColors.background;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 10;
    final path = Path();
    path.moveTo(0, size.height * .7);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * .7);
    path.lineTo(0, size.height * .7);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({
    Key? key,
    required this.size,
    required this.percent,
    this.title,
    this.onTap,
    this.onTapAction,
    required this.showAction,
  }) : super(key: key);

  final Size size;
  final double percent;
  final String? title;
  final VoidCallback? onTap;
  final VoidCallback? onTapAction;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    final translateRow = 1 - (10 * percent);
    return Positioned(
      top: kToolbarHeight * .65,
      left: S2BSpacing.sm,
      right: S2BSpacing.sm,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..translate(S2BSpacing.zero, translateRow),
        child: Row(
          children: [
            BackButton(
              color: S2BColors.white,
              onPressed: onTap,
            ),
            const SizedBox(
              width: S2BSpacing.xs,
            ),
            TextLabel.body(
              title ?? '',
              fontWeight: FontWeight.w700,
              color: S2BColors.white,
            ),
            const Spacer(),
            if (showAction)
              IconButton(
                onPressed: onTapAction,
                icon: const Icon(
                  FontAwesomeIcons.upload,
                  size: 18,
                  color: S2BColors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SpacingFlexible extends StatelessWidget {
  const SpacingFlexible({
    Key? key,
    required this.size,
    required this.percent,
    this.title,
  }) : super(key: key);

  final Size size;
  final double percent;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final leftText = S2BSpacing.lg - (200 * percent);
    final opacityText = (1 - (percent * 5)).clamp(0.0, 1.0);
    return Positioned(
      left: leftText,
      bottom: S2BSpacing.xl,
      width: size.width - S2BSpacing.xxl,
      child: Opacity(
        opacity: opacityText,
        child: TextLabel.body(
          title ?? '',
          fontWeight: FontWeight.w700,
          color: S2BColors.white,
        ),
      ),
    );
  }
}

class BtnCircular extends StatelessWidget {
  const BtnCircular({
    Key? key,
    required this.size,
    required this.percent,
    this.onTap,
    this.icon,
  }) : super(key: key);

  final Size size;
  final double percent;
  final Icon? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final heightFloating = size.height * .135 + (-155 * percent);
    final scaleFloating = (1 + (-5 * percent)).clamp(0.0, 1.0);
    return Positioned(
      top: heightFloating,
      left: size.width - S2BSpacing.lg - 60,
      child: Transform.scale(
        scale: scaleFloating,
        child: FloatingActionButton(
          onPressed: onTap,
          backgroundColor: S2BColors.orange,
          child: icon,
        ),
      ),
    );
  }
}

class BackgroundSliver extends StatelessWidget {
  const BackgroundSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: S2BSpacing.zero,
      bottom: S2BSpacing.zero,
      left: S2BSpacing.zero,
      right: S2BSpacing.zero,
      child: Container(
        color: S2BColors.primaryColor,
      ),
    );
  }
}
