import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/notification_card.dart';
import '../notification_tile/notification_tile.dart';
import '../notification_tile/slide_button.dart';

typedef void OnTapSlidButtonCallback(int index);

/// This widget is shown after animating [AnimatedOffsetList].
/// Show all cards in a column, with the option to slide each card.
class ExpandedList extends StatelessWidget {
  final List<NotificationCard> notificationCards;
  final AnimationController controller;
  final double initialSpacing;
  final double spacing;
  final double endPadding;
  final double containerHeight;

  const ExpandedList({
    Key? key,
    required this.notificationCards,
    required this.controller,
    required this.containerHeight,
    required this.initialSpacing,
    required this.spacing,
    required this.endPadding,
  }) : super(key: key);

  /// Determines whether to show the [ExpandedList] or not
  /// When [AnimatedOffsetList] is shown this widget will not be shown.
  /// When there is only one notification then [ExpandedList] will
  /// always be shown.
  bool _getListVisibility(int length) {
    if (length == 1) {
      return true;
    } else if (controller.value >= 0.8) {
      return true;
    } else {
      return false;
    }
  }

  /// The padding that will be shown at the bottom of
  /// all card, basically bottom padding of [ExpandedList]
  double _getEndPadding(int index) {
    if (index == notificationCards.length - 1) {
      return endPadding;
    } else {
      return 0;
    }
  }

  /// Spacing between two cards this value used
  /// to add padding under each SlidButton
  double _getSpacing(int index, double topSpace) {
    if (index == 0) {
      return 0;
    } else {
      return topSpace;
    }
  }

  /// Top padding of each cards initial padding will
  /// be same as AnimatedOffsetList inter card spacing
  /// then it will shrink (while animating). This will
  /// give bounce animation when cards are expanding.
  double _topPadding(int index) {
    return Tween<double>(begin: _getSpacing(index, initialSpacing), end: _getSpacing(index, spacing))
        .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.8, 1.0),
          ),
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final reversedList = List.of(notificationCards);
    reversedList.sort((a, b) => b.couponNo.compareTo(a.couponNo));
    return Visibility(
      visible: _getListVisibility(reversedList.length),
      child: Column(
        key: ValueKey('ExpandedList'),
        children: [
          ...reversedList.map(
            (notification) {
              final index = reversedList.indexOf(notification);
              return BuildWithAnimation(
                key: ValueKey(notification.couponNo),
                // slidKey: ValueKey(notification.dateTime),
                spacing: _getSpacing(index, spacing),
                index: index,
                endPadding: _getEndPadding(index),
                child: GestureDetector(
                  key: ValueKey('onTapExpand' + notification.couponNo),
                  onTap: () {
                    controller.reverse();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                    child: NotificationTile(
                      purchaseDate: notification.purchaseDate,
                      product: notification.product,
                      drawDate: notification.drawDate,
                      prize: notification.prize,
                      couponNo: notification.couponNo,
                      logo: notification.logo,
                      height: containerHeight,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// This widget is used to animate each card when clear action is selected

class BuildWithAnimation extends StatefulWidget {
  final Widget child;
  final int index;
  final double endPadding;
  final double spacing;
  // final Key slidKey;

  const BuildWithAnimation({
    Key? key,
    required this.child,
    required this.index,
    required this.endPadding,
    required this.spacing,
  }) : super(key: key);

  @override
  _BuildWithAnimationState createState() => _BuildWithAnimationState();
}

class _BuildWithAnimationState extends State<BuildWithAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: ValueKey('BuildWithAnimation'),
      animation: _animationController,
      builder: (_, __) => Opacity(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animationController).value,
        child: SizeTransition(
          sizeFactor: Tween<double>(begin: 1.0, end: 0.0).animate(_animationController),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
