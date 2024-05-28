import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerMoviePoster extends StatelessWidget {
  const ShimmerMoviePoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 116.0,
          maxWidth: 116.0,
          minHeight: 200.0,
          maxHeight: 200.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey,
        ),
      ),
    );
  }
}
