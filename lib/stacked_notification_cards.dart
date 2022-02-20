library stacked_notification_cards;

import 'package:flutter/material.dart';

import 'src/build_stacked_notification.dart';
import 'src/model/notification_card.dart';
import 'src/stacked_cards/expanded_list.dart';

export 'src/model/notification_card.dart';

/// This package will let you
class StackedNotificationCards extends StatelessWidget {
  /// List of [NotificationCard]s to show.
  final List<NotificationCard> notificationCards;
  /// Spacing between [NotificationCard]s  when they are expanded.
  final double cardsSpacing;
  /// Padding around the whole widget.
  final double padding;

  const StackedNotificationCards({
    Key? key,
    required this.notificationCards,
    this.cardsSpacing = 10,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notificationCards.length > 0) {
      return BuildStackedNotification(
        key: ValueKey('BuildStackedNotification'),
        notificationCards: notificationCards,
        spacing: cardsSpacing,
        padding: padding,
      );
    } else {
      return SizedBox.shrink(
        key: ValueKey('EmptySizedBox'),
      );
    }
  }
}
