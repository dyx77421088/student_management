import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 微光
class DYXShimmer extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  DYXShimmer({@required this.child, this.baseColor=Colors.black, this.highlightColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: child
    );
  }
}
