import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class AppTextStyles {
  static const TextStyle giftName = TextStyle(
    fontFamily: 'Arial',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  static const TextStyle giftDescription = TextStyle(fontSize: 16);

  static const TextStyle giftRecipient = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );
}
