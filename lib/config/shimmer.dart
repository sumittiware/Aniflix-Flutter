import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Radius borderRadius;

  const LoaderWidget.rectangular(
      {this.width = double.infinity,
      this.borderRadius = const Radius.circular(12),
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      loop: 3,
      direction: ShimmerDirection.btt,
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[400]!,
      period: const Duration(seconds: 2),
      child: Container(
          width: width,
          height: height,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(borderRadius))),
    );
  }
}
