import 'package:flutter/material.dart';
import 'package:gift_tracker_app/view/screen/add_gift_screen.dart';

import '../../core/color/app_colors.dart';
import '../../data/gift_data.dart';
import '../../data/model/gift_model.dart';
import '../widget/custom_gift_card.dart';

class GiftListScreen extends StatefulWidget {
  const GiftListScreen({super.key});

  @override
  State<GiftListScreen> createState() => _GiftListScreenState();
}

class _GiftListScreenState extends State<GiftListScreen> {
  void _navigateToAddGift() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AddGiftScreen(
              onGiftAdded: (Gift newGift) {
                setState(() {
                  giftList.add(newGift);
                });
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Gifts')),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: giftList.length,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemBuilder: (context, index) {
              final gift = giftList[index];
              return CustomGiftCard(gift: gift);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  onPressed: _navigateToAddGift,
                  icon: const Icon(Icons.add, size: 25),
                  label: const Text('Add Gift', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
