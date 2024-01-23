import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/create_highlight_screen.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/drag_to_delete_drop_target_widget.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_image.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/type_your_highlight_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateHighlightPhotoViewBuilderBody extends ConsumerWidget {
  final bool isKeyboardVisible;
  final Slide slideItem;
  final Color textColor;

  const CreateHighlightPhotoViewBuilderBody({
    required this.isKeyboardVisible,
    required this.slideItem,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(currentlySelectedSlideContentTextItemId.notifier).state = '';
      },
      child: SingleChildScrollView(
        physics: isKeyboardVisible
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        controller: ref.read(scrollControllerProvider.notifier).state,
        padding: const EdgeInsets.only(
          bottom: 300.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: slideItem.backgroundColor,
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final slideTextContentStateProviderState = ref.watch(
                    slideTextContentStateProvider(
                      slideItem.tempUniqueId ?? '',
                    ),
                  );

                  final slideImagesContentProviderState = ref.watch(
                    slideImageContentStateProvider(
                      slideItem.tempUniqueId ?? '',
                    ),
                  );

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      //render media list

                      Stack(
                        alignment: Alignment.center,
                        children: List.generate(
                          slideImagesContentProviderState.length,
                          (index) {
                            return DraggableResizableSlideImage(
                              slideTempUniqueId: slideItem.tempUniqueId ?? '',
                              textColor: textColor,
                              slideImageContentObject:
                                  slideImagesContentProviderState[index],
                            );
                          },
                        ),
                      ),

                      //render slide content text list
                      Stack(
                        alignment: Alignment.center,
                        children: List.generate(
                          slideTextContentStateProviderState.length,
                          (index) {
                            return DraggableResizableSlideText(
                              slideTempUniqueId: slideItem.tempUniqueId ?? '',
                              textColor: textColor,
                              slideTextObject:
                                  slideTextContentStateProviderState[index],
                              constraints: constraints,
                            );
                          },
                        ),
                      ),

                      Visibility(
                        visible: (ref
                                .watch(slideTextContentStateProvider(
                                    slideItem.tempUniqueId ?? ''))
                                .isEmpty) &&
                            !(ref.watch(showHighlightEditorScreenLoader)),
                        child: Align(
                          alignment: Alignment.center,
                          child: TypeYourHighlightTextButton(
                            tempUniqueId: slideItem.tempUniqueId ?? '',
                            textColor: textColor,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DragToDeleteDropTargetWidget(
                          uniqueId: slideItem.tempUniqueId ?? '',
                          textColor: textColor,
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
