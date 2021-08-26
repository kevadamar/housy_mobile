import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final Widget widget;

  const ShimmerEffect({Key key, @required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        child: widget,
        baseColor: Colors.grey[400],
        highlightColor: Colors.grey[300],
      );
}
