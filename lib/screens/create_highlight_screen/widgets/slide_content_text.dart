import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/slide_text_content_field.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideContentTextWithObjectWidget extends ConsumerWidget {
  final SlideTextContent? slideTextObject;
  final Color? textColor;
  final String? slideTempUniqueId;
  final double scaleFactor;

  const SlideContentTextWithObjectWidget({
    required this.slideTextObject,
    required this.textColor,
    required this.scaleFactor,
    this.slideTempUniqueId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.scale(
      scale: (slideTextObject?.fontSize ?? 1) * 0.07,
      child: IntrinsicWidth(
        stepWidth: 60,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 3.0,
            horizontal: 3.0,
          ),
          decoration: BoxDecoration(
            color: slideTextObject?.textBackgroundColor ?? Colors.transparent,
            border: Border.all(
              color: ref.watch(currentlySelectedSlideContentTextItemId) ==
                      (slideTextObject?.id ?? '')
                  ? CustomColors.orange400
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: SlideTextContentField(
            slideContentObject: slideTextObject,
            textColor: textColor ?? Colors.white,
            uid: slideTempUniqueId ?? '',
            isUpperCased: slideTextObject?.toUpperCase ?? false,
          ),
        ),
      ),
    );
  }
}
