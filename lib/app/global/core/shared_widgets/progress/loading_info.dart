import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe2biz/app/global/core/core.dart';

class LoadingInfo {
  static void show({
    required BuildContext context,
    String? message,
  }) {
    showDialog(
      context: context,
      barrierColor: S2BColors.black.withOpacity(0.8),
      barrierDismissible: false,
      builder: (context) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _LoadingInfoWidget(
          message: message,
        ),
      ),
    );
  }
}

class _LoadingInfoWidget extends StatelessWidget {
  final String? message;
  const _LoadingInfoWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RotateSection(
          child: SizedBox(
            width: 46.0,
            height: 46.0,
            child: SvgPicture.asset(
              'assets/icons/loading.svg',
            ),
          ),
        ),
        const SizedBox(
          height: S2BSpacing.sl,
        ),
        TextLabel.body(
          message ?? '',
          textAlign: TextAlign.center,
          color: S2BColors.white,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class RotateSection extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const RotateSection({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  _RotateSectionState createState() => _RotateSectionState();
}

class _RotateSectionState extends State<RotateSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _prepareAnimation();
  }

  void _prepareAnimation() {
    _rotationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_rotationController);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}
