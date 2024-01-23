import 'dart:async';
import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/providers/slides.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/create_highlight_photoview_builder_body.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/create_highlight_top_bar_widget.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_action_buttons/slide_action_buttons.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/floating_action_buttons/slide_text_action_buttons/slide_text_bottom_action_buttons_bar.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/slides_indicator.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreateHighlightScreen extends ConsumerStatefulWidget {
  const CreateHighlightScreen({
    super.key,
  });

  @override
  ConsumerState<CreateHighlightScreen> createState() =>
      _CreateHighlightScreenState();
}

class _CreateHighlightScreenState extends ConsumerState<CreateHighlightScreen> {
  bool createSlidesIsLoading = false;
  bool isKeyboardVisible = false;
  late PageController pageController;
  late ScreenshotController screenshotController;
  late KeyboardVisibilityController _keyboardVisibilityController;
  late StreamSubscription<bool> keyboardSubscription;

  scrollToBottom() {
    ref.read(scrollControllerProvider).animateTo(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 80),
          0.0,
        );
  }

  @override
  void initState() {
    _keyboardVisibilityController = KeyboardVisibilityController();
    pageController = ref.read(pageControllerStateProvider.notifier).state;
    screenshotController =
        ref.read(screenShotControllerStateProvider.notifier).state;
    addKeyBoardSubscription();
    super.initState();
  }

  addKeyBoardSubscription() {
    keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        if (visible == false) {
          scrollToBottom();
        }
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();

    super.dispose();
  }

  bool clearCurrentlySlideId = true;

  @override
  Widget build(BuildContext context) {
    final slides = ref.watch(createSlideProvider).slides;

    if (slides.isEmpty) {
      return const Scaffold();
    }

    final currentPageIndex = ref.watch(currentCarouselIndex);

    final Color textColor = getTextColorForBackground(
      slides.isNotEmpty
          ? slides[currentPageIndex].backgroundColor ?? Colors.black
          : Colors.black,
    );

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(
        controller: _keyboardVisibilityController,
        builder: (context, _) {
          return Stack(
            children: [
              Screenshot(
                controller: screenshotController,
                child: PhotoViewGallery.builder(
                  backgroundDecoration: const BoxDecoration(
                    color: CustomColors.backgroundColor,
                  ),
                  itemCount: slides.length,
                  pageController: pageController,
                  scrollPhysics: (slides.length <= 1)
                      ? const NeverScrollableScrollPhysics()
                      : const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (i) {
                    ref.read(currentCarouselIndex.notifier).state = i;

                    if (clearCurrentlySlideId) {
                      ref
                          .read(
                              currentlySelectedSlideContentTextItemId.notifier)
                          .state = '';
                    }

                    ref.read(createSlidesScrollController).scrollToIndex(
                          i,
                          duration: const Duration(milliseconds: 200),
                        );

                    // ref.read(textFieldVisibilityStateProvider.notifier).state =
                    //     true;

                    setState(() {
                      clearCurrentlySlideId = true;
                    });

                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  builder: (context, index) {
                    final Slide slideItem = slides[index];

                    final Color textColor = getTextColorForBackground(
                      slides.isNotEmpty
                          ? slideItem.backgroundColor ?? Colors.black
                          : Colors.black,
                    );

                    return PhotoViewGalleryPageOptions.customChild(
                      childSize: MediaQuery.of(context).size,
                      gestureDetectorBehavior: HitTestBehavior.deferToChild,
                      disableGestures: true,
                      minScale: PhotoViewComputedScale.covered,
                      maxScale: PhotoViewComputedScale.covered,
                      child: CreateHighlightPhotoViewBuilderBody(
                        isKeyboardVisible: isKeyboardVisible,
                        slideItem: slideItem,
                        textColor: textColor,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: HighlightScreenTopBar(
                  slidesLength: slides.length,
                  textColor: textColor,
                  currentPageIndex: currentPageIndex,
                  isButtonActive: ((ref
                          .watch(
                            slideTextContentStateProvider(
                                slides[slides.length - 1].tempUniqueId ?? ''),
                          )
                          .isNotEmpty) ||
                      ref
                          .watch(
                            slideImageContentStateProvider(
                                slides[slides.length - 1].tempUniqueId ?? ''),
                          )
                          .isNotEmpty),
                ),
              ),
              Visibility(
                visible: ref.watch(showHighlightEditorScreenLoader),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white70,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.orange400,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: !(ref.watch(showHighlightEditorScreenLoader)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeInCirc,
                switchOutCurve: Curves.easeOutCirc,
                reverseDuration: const Duration(
                  milliseconds: 200,
                ),
                duration: const Duration(
                  milliseconds: 200,
                ),
                child: ref
                        .watch(currentlySelectedSlideContentTextItemId)
                        .isNotEmpty
                    ? SlideTextActionBottomButtons(
                        textColor: textColor,
                        slideTempUniqueId:
                            slides[currentPageIndex].tempUniqueId ?? '',
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 80.0, left: 8.0),
                        child: SlideActionButtons(
                          textColor: textColor,
                          slideItem: slides[ref.read(currentCarouselIndex)],
                          slidesLength: slides.length,
                          pageController: pageController,
                        ),
                      ),
              ),
            ),
            Visibility(
              visible:
                  ref.watch(currentlySelectedSlideContentTextItemId).isEmpty,
              child: FloatingActionButton(
                heroTag: 'highlight_screen',
                onPressed: () {
                  setState(() {
                    clearCurrentlySlideId = false;
                  });

                  ref.read(createSlideProvider.notifier).createInitialSlide(
                        indexAfter: currentPageIndex + 1,
                      );

                  ref.read(currentCarouselIndex.notifier).state++;

                  pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn,
                  );
                  ref.read(createSlidesScrollController).scrollToIndex(
                        currentPageIndex,
                        duration: const Duration(milliseconds: 100),
                      );

                  ref
                      .read(currentlySelectedSlideContentTextItemId.notifier)
                      .state = '';
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final currentCarouselIndex = StateProvider<int>((ref) => 0);
final scrollControllerProvider = StateProvider((ref) => ScrollController());

final pageControllerStateProvider = StateProvider((ref) => PageController());
final screenShotControllerStateProvider =
    StateProvider((ref) => ScreenshotController());
final showHighlightEditorScreenLoader = StateProvider((ref) => false);
