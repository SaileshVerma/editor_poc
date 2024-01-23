import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_text_action_buttons/edit_slide_text_bottom_sheet_action_button.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_text_action_buttons/slide_fontsize_slider_button.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_text_action_buttons/text_bg_color_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideTextActionBottomButtons extends ConsumerWidget {
  final Color textColor;
  final String slideTempUniqueId;

  const SlideTextActionBottomButtons({
    required this.textColor,
    required this.slideTempUniqueId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelectedTextObject = ref
        .watch(slideTextContentStateProvider(slideTempUniqueId).notifier)
        .getCurrentSelectedSlideTextObjectById(
          id: ref.watch(currentlySelectedSlideContentTextItemId),
        );

    return Padding(
      padding: const EdgeInsets.only(left: 26.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SlideFontSizeSliderButton(
            currentSelectedTextObject: currentSelectedTextObject,
            slideTempUniqueId: slideTempUniqueId,
            textColor: textColor,
          ),
          // FontFamilyPickerBottomSheetButton(
          //   slideTempUniqueId: slideTempUniqueId,
          //   textColor: textColor,
          //   currentSelectedTextObject: currentSelectedTextObject,
          // ),

          TextBgColorPicker(
            slideUniqueId: slideTempUniqueId,
            currentSelectedTextObjectId: currentSelectedTextObject.id ?? '',
            textColor: textColor,
            currentTextBgColor: currentSelectedTextObject.textBackgroundColor ??
                Colors.transparent,
          ),

          EditSlideTextBottomActionButton(
            slideTempUniqueId: slideTempUniqueId,
            textColor: textColor,
            currentSelectedTextObject: currentSelectedTextObject,
          ),
        ],
      ),
    );
  }
}
