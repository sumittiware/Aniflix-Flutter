import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Radius borderRadius;

  const LoaderWidget.rectangular(
      {Key? key,
      this.width = double.infinity,
      this.borderRadius = const Radius.circular(12),
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      loop: 5,
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[700]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
          margin: const EdgeInsets.all(8),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(borderRadius))),
    );
  }
}
