import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTextToSlideContentActionButton extends ConsumerWidget {
  final String uid;
  final Color textColor;

  const AddTextToSlideContentActionButton({
    required this.uid,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Icon(
        Icons.text_fields_rounded,
        size: 30,
        color: textColor,
      ),
      onTap: () {
        ref
            .read(slideTextContentStateProvider(uid).notifier)
            .addInitialTextToStateList();
      },
    );
  }
}
