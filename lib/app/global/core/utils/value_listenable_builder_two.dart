import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilderTwo<A, B> extends StatelessWidget {
  const ValueListenableBuilderTwo({
    Key? key,
    required this.valueListenableA,
    required this.valueListenableB,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> valueListenableA;
  final ValueListenable<B> valueListenableB;
  final Widget? child;
  final Widget Function(BuildContext context, A valueA, B valueB, Widget? child)
      builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: valueListenableA,
      builder: (_, valueA, __) {
        return ValueListenableBuilder<B>(
          valueListenable: valueListenableB,
          builder: (context, valueB, __) {
            return builder(context, valueA, valueB, child);
          },
        );
      },
    );
  }
}
