import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TypeYourHighlightTextButton extends ConsumerWidget {
  final String tempUniqueId;
  final Color textColor;

  const TypeYourHighlightTextButton({
    required this.tempUniqueId,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref
            .read(slideTextContentStateProvider(tempUniqueId).notifier)
            .addInitialTextToStateList();
      },
      child: Text(
        'Type your highlight',
        style: TextStyle(
          color: textColor.withOpacity(0.5),
          fontSize: 26,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
