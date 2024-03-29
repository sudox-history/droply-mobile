import 'package:flutter/material.dart';
import 'package:droply/constants.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget body;
  final Widget footer;
  final String title;
  final String description;
  final double headerBodyMargin;
  final double bodyFooterMargin;

  const BottomSheetContainer({
    this.body,
    this.footer,
    @required this.title,
    @required this.description,
    @required this.headerBodyMargin,
    @required this.bodyFooterMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.semibold,
                color: AppColors.invariantPrimaryTextColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.openSans,
                fontWeight: AppFonts.regular,
                color: AppColors.secondaryTextColor,
              ),
            ),
            SizedBox(height: headerBodyMargin),
            body,
            SizedBox(height: bodyFooterMargin),
            footer,
          ],
        ),
      ),
    );
  }
}
