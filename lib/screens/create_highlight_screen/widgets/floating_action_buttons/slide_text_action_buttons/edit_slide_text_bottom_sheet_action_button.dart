import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_text_action_buttons/animated_copy_edit_text_button.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSlideTextBottomActionButton extends ConsumerWidget {
  final String slideTempUniqueId;
  final Color textColor;
  final SlideTextContent currentSelectedTextObject;

  const EditSlideTextBottomActionButton({
    required this.currentSelectedTextObject,
    required this.slideTempUniqueId,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            'More Options',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          )),
      onTap: () {
        showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (ctx) {
            return IntrinsicHeight(
              child: Container(
                color: CustomColors.backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          splashColor: CustomColors.lightGrey2,
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: currentSelectedTextObject.text ?? '',
                              ),
                            ).then(
                              (_) {
                                ref
                                    .read(slideTextContentStateProvider(
                                            slideTempUniqueId)
                                        .notifier)
                                    .onChangedSlideContentTextUpdated(
                                      id: ref.watch(
                                          currentlySelectedSlideContentTextItemId),
                                      str: '',
                                      toCutText: true,
                                    );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.cut,
                            color: CustomColors.greyDark1,
                          ),
                        ),
                        const Text(
                          'Cut',
                          style: TextStyle(
                            color: CustomColors.greyDark1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    CopySlideTextActionIcon(
                      currentSelectedTextObject: currentSelectedTextObject,
                    ),
                    Column(
                      children: [
                        IconButton(
                          splashColor: CustomColors.lightGrey2,
                          onPressed: () {
                            ref
                                .read(slideTextContentStateProvider(
                                        slideTempUniqueId)
                                    .notifier)
                                .duplicateTextObject(
                                  selectedTextToBeDuplicatedId:
                                      currentSelectedTextObject.id ?? '',
                                );
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: CustomColors.greyDark1,
                          ),
                        ),
                        const Text(
                          'Duplicate',
                          style: TextStyle(
                            color: CustomColors.greyDark1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            splashColor: CustomColors.lightGrey2,
                            onPressed: () {
                              ref
                                  .read(slideTextContentStateProvider(
                                          slideTempUniqueId)
                                      .notifier)
                                  .deleteSlideContentTextObject(
                                    id: currentSelectedTextObject.id ?? '',
                                  );
                            },
                            icon: Icon(Icons.delete)),
                        const Text(
                          'Delete',
                          style: TextStyle(
                            color: CustomColors.greyDark1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
