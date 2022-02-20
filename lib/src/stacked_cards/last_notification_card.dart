import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../clipp.dart';
import '../model/notification_card.dart';

/// [LastNotificationCard] is the topmost card on the stack

class LastNotificationCard extends StatelessWidget {
  final AnimationController controller;
  final NotificationCard notification;
  final int totalCount;
  final double height;

  const LastNotificationCard({
    Key? key,
    required this.controller,
    required this.notification,
    required this.totalCount,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: totalCount > 1 && controller.value <= 0.4,
      child: GestureDetector(
        key: ValueKey('onTapExpand'),
        onTap: () {
          Slidable.of(context)?.close();
          controller.forward();
        },
        child: PhysicalShape(
          clipper: TicketClipper(),
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.grey.shade100,
          key: ValueKey('LastNotificationCard'),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(notification.logo, width: 120),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(notification.prize,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.blue)),
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: "Product: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w700),
                              children: <TextSpan>[
                                TextSpan(
                                    text: notification.product,
                                    style: const TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: "Coupon no: ",
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w700),
                          children: <TextSpan>[
                            TextSpan(
                                text: notification.couponNo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.watch_later,
                                color: Colors.grey.shade400),
                          ),
                          Text(
                            'Draw on ' + notification.drawDate,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Opacity(
                    opacity: Tween(begin: 1.0, end: 0.0)
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: Interval(0.0, 0.2),
                          ),
                        )
                        .value,
                    child: Container(
                      width: 32,
                      height: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xff40e7f2),
                      ),
                      child: Text(
                        totalCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
