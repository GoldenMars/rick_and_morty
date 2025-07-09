import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class TwoDimensionalScrollView extends StatelessWidget {
  final dynamic primary;

  final dynamic mainAxis;

  final dynamic verticalDetails;

  final dynamic horizontalDetails;

  final dynamic delegate;

  final dynamic cacheExtent;

  final dynamic diagonalDragBehavior;

  final dynamic dragStartBehavior;

  final dynamic keyboardDismissBehavior;

  final dynamic clipBehavior;

  final dynamic hitTestBehavior;

  const TwoDimensionalScrollView({
    super.key,
    this.primary,
    this.mainAxis = Axis.vertical,
    this.verticalDetails = const ScrollableDetails.vertical(),
    this.horizontalDetails = const ScrollableDetails.horizontal(),
    required this.delegate,
    this.cacheExtent,
    this.diagonalDragBehavior = DiagonalDragBehavior.none,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior = HitTestBehavior.opaque,
  });
}
