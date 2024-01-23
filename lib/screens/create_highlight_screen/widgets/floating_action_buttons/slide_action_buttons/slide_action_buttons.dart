import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_action_buttons/add_text_to_slide_button.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_action_buttons/bg_color_picker_action_button.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_action_buttons/delete_slide_button_widget.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_action_buttons/image_picker_action_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideActionButtons extends ConsumerWidget {
  final Color textColor;
  final Slide slideItem;
  final int slidesLength;
  final PageController pageController;

  const SlideActionButtons({
    required this.textColor,
    required this.slideItem,
    required this.slidesLength,
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ImagePickerButton(
          textColor: textColor,
          uid: slideItem.tempUniqueId ?? '',
        ),
        AddTextToSlideContentActionButton(
          textColor: textColor,
          uid: slideItem.tempUniqueId ?? '',
        ),
        BgColorChangerActionButton(
          textColor: textColor,
          currentSlideBgColor: slideItem.backgroundColor ?? Colors.black,
          slideUniqueId: slideItem.tempUniqueId ?? '',
        ),
        DeleteSlideButtonWidget(
          slideTempUniqueId: slideItem.tempUniqueId ?? '',
          slidesLength: slidesLength,
          pageController: pageController,
          textColor: textColor,
        ),
      ],
    );
  }
}
