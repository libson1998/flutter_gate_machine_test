import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final int itemCount;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollPhysics? scrollPhysics;
  final double? childAspectRatio;
final ScrollController ?scrollController;
  const GridViewWidget(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      required this.crossAxisSpacing,
      required this.crossAxisCount,
      required this.mainAxisSpacing,
      this.scrollPhysics,
        this.childAspectRatio,   this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.zero,
      physics: scrollPhysics,
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: childAspectRatio!,
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
      ),
    );
  }
}
