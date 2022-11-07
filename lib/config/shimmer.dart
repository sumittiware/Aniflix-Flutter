import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Radius borderRadius;

  const LoaderWidget.rectangular(
      {Key? key,
      this.width = double.infinity,
      this.borderRadius = const Radius.circular(4),
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
          borderRadius: BorderRadius.all(borderRadius),
        ),
      ),
    );
  }
}

class BannerLoader extends StatefulWidget {
  const BannerLoader({Key? key}) : super(key: key);

  @override
  State<BannerLoader> createState() => _BannerLoaderState();
}

class _BannerLoaderState extends State<BannerLoader> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            loop: 5,
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[700]!,
            period: const Duration(milliseconds: 1500),
            child: Container(
              margin: const EdgeInsets.all(8),
              width: size.width * 0.75,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Shimmer.fromColors(
            loop: 5,
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[700]!,
            period: const Duration(milliseconds: 1500),
            child: Container(
              margin: const EdgeInsets.all(8),
              width: size.width * 0.55,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
