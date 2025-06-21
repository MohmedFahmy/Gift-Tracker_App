import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/color/app_colors.dart';
import '../../core/util/responsive.dart';
import '../../data/model/gift_model.dart';

class CustomGiftCard extends StatelessWidget {
  const CustomGiftCard({super.key, required this.gift});

  final Gift gift;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: responsive.dynamicPadding(8)),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(responsive.dynamicPadding(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    gift.name,
                    style: TextStyle(
                      fontSize: responsive.dynamicFont(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (shouldShowReminderIcon(gift))
                  Icon(
                    Icons.notifications_active,
                    color: AppColors.reminderIcon,
                    size: responsive.dynamicFont(20),
                  ),
              ],
            ),
            SizedBox(height: responsive.dynamicPadding(8)),
            Text(
              'Description: ${gift.description}',
              style: TextStyle(fontSize: responsive.dynamicFont(14)),
            ),
            SizedBox(height: responsive.dynamicPadding(4)),
            Text(
              'For: ${gift.recipient}',
              style: TextStyle(fontSize: responsive.dynamicFont(14)),
            ),
            if (shouldShowReminderIcon(gift))
              Padding(
                padding: EdgeInsets.only(top: responsive.dynamicPadding(6)),
                child: Text(
                  'Event: ${gift.eventName} on ${DateFormat.yMMMd().format(gift.eventDate!)}',
                  style: TextStyle(
                    fontSize: responsive.dynamicFont(13.5),
                    color: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

bool shouldShowReminderIcon(Gift gift) {
  final now = DateTime.now();
  return gift.eventDate != null && gift.eventDate!.isAfter(now);
}
