import 'package:flutter/material.dart';
import 'stacked_cards/stacked_cards.dart';
import 'stacked_cards/expanded_list.dart';

import 'stacked_notification_actions/stacked_notification_actions.dart';
import 'model/notification_card.dart';

class BuildStackedNotification extends StatefulWidget {
  final List<NotificationCard> notificationCards;
  final double spacing;
  final double padding;

  BuildStackedNotification({
    Key? key,
    required this.notificationCards,
    required this.spacing,
    required this.padding,
  }) : super(key: key);

  @override
  _BuildStackedNotificationState createState() =>
      _BuildStackedNotificationState();
}

class _BuildStackedNotificationState extends State<BuildStackedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final double _containerHeight = 220;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationCards = widget.notificationCards;
    final spacing = widget.spacing;
    final padding = widget.padding;

    /// needs to sort to show the list in ascending date order
    notificationCards.sort((a, b) => a.couponNo.compareTo(b.couponNo));

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Column(
        key: ValueKey('NotificationList'),
        children: [
          StackedCards(
            key: ValueKey('CollapsedCards'),
            controller: _animationController,
            notificationCards: notificationCards,
            containerHeight: _containerHeight,
            spacing: spacing,
            maxSpacing: 2 * spacing,
            padding: padding,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
