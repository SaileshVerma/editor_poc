import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/back_button_with_alert_dialog_widget.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/slides_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HighlightScreenTopBar extends ConsumerWidget {
  const HighlightScreenTopBar({
    required this.textColor,
    required this.slidesLength,
    required this.currentPageIndex,
    required this.isButtonActive,
    super.key,
  });

  final Color textColor;
  final int slidesLength;
  final int currentPageIndex;
  final bool isButtonActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButtonWithOnClickAlertDialog(
            textColor: textColor,
          ),
          SlidesIndicator(
            slidesLength: slidesLength,
            textColor: textColor,
            currentPageIndex: currentPageIndex,
          ),
        ],
      ),
    );
  }
}
