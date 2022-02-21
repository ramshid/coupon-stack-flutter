import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/notification_card.dart';
import '../notification_tile/slide_button.dart';
import 'animated_offset_list.dart';
import 'expanded_list.dart';
import 'last_notification_card.dart';
import 'offset_spacer.dart';

/// Shows stack of cards
///
/// This widget is responsible for showing the stack of cards along with the fan animation on expansion. Also handles [OnTapSlidButtonCallback].
class StackedCards extends StatelessWidget {
  final AnimationController controller;
  final List<NotificationCard> notificationCards;
  final double containerHeight;
  final double spacing;
  final double maxSpacing;
  final double padding;

  StackedCards({
    Key? key,
    required this.controller,
    required this.notificationCards,
    required this.containerHeight,
    required this.spacing,
    required this.maxSpacing,
    required this.padding,
  }) : super(key: key);

  /// This method gives the bottom padding that is used
  /// for 'Clear All' bottom when stacked cards are slid over
  double _getSlidButtonPadding() {
    final length = notificationCards.length;
    if (length == 1) {
      return padding;
    } else if (length == 2) {
      return spacing + padding;
    } else {
      return (2 * spacing) + padding;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// this notification will be shown in [LastNotificationCard]
    final lastNotification = notificationCards.last;

    /// Wrapped in [Slidable], this will help to slide when cards are stacked.
    return Stack(
      children: [
        OffsetSpacer(
          height: containerHeight,
          controller: controller,
          spacing: 2 * spacing,
          notificationCount: notificationCards.length,
          padding: padding,
        ),
        AnimatedOffsetList(
          controller: controller,
          interval: Interval(0.4, 0.8),
          notificationCards: notificationCards,
          height: containerHeight,
          spacing: maxSpacing,
          opacityInterval: Interval(0.4, 0.6),
        ),
        LastNotificationCard(
          controller: controller,
          notification: lastNotification,
          totalCount: notificationCards.length,
          height: containerHeight,
        ),
        ExpandedList(
          controller: controller,
          containerHeight: containerHeight,
          spacing: spacing,
          initialSpacing: 2 * spacing,
          notificationCards: notificationCards,
          endPadding: padding,
        ),
      ],
    );
  }
}
