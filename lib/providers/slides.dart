import 'dart:math';
import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/providers/slide_state.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateSlidesNotifier extends StateNotifier<SlidesState> {
  CreateSlidesNotifier(this.ref) : super(SlidesState.empty);

  Ref ref;

  void createInitialSlide({required int indexAfter}) {
    final slide = Slide(
      tempUniqueId: DateTime.now().toIso8601String(),
      backgroundColor: backgroundFillColorArray[
          Random().nextInt(backgroundFillColorArray.length)],
      slideContentTexts: const [],
      slideContentImages: const [],
    );

    var currentList = state.slides;
    currentList.insert(indexAfter, slide);

    state = state.copyWith(
      slides: currentList,
    );
  }

  void updateSlideColor({
    required Color backgroundColor,
    required String slideUniqueId,
  }) {
    final slides = state.slides;

    var slideItem = slides.firstWhere(
      (element) => element.tempUniqueId == slideUniqueId,
    );

    slideItem = slides[slides
            .indexWhere((element) => element.tempUniqueId == slideUniqueId)] =
        slideItem.copyWith(backgroundColor: backgroundColor);

    state = state.copyWith(
      slides: slides,
    );
  }

  void updateCurrentSlide({required List<Slide> slides}) {
    state = state.copyWith(
      slides: [...slides],
    );
  }

  void deleteSlideFromState({
    required int index,
    required String slideTempUniqueId,
  }) {
    final slides = state.slides;

    slides.removeAt(index);

//clearing states for slide content images and texts states.
    ref
        .read(slideTextContentStateProvider(slideTempUniqueId).notifier)
        .clearCurrentFamilyState();
    ref
        .read(slideImageContentStateProvider(slideTempUniqueId).notifier)
        .clearCurrentFamilyState();

    state = state.copyWith(
      slides: slides,
    );
  }

  void resetStateData() {
    // ref.read(currentCarouselIndex.notifier).state = 0;
    ref.invalidate(currentlySelectedSlideContentTextItemId);
    // ref
    //     .read(slideScrollController)
    //     .scrollToIndex(0, duration: const Duration(milliseconds: 100));

    // ref.invalidate(progressValueStateProvider);
    ref.invalidate(slideTextContentStateProvider);
    ref.invalidate(slideImageContentStateProvider);
    // ref.invalidate(screenShotControllerStateProvider);
    // ref.invalidate(pageControllerStateProvider);

    state = state.copyWith(
      highlightId: '',
      slides: [],
    );
  }
}

final createSlideProvider =
    StateNotifierProvider<CreateSlidesNotifier, SlidesState>(
  (ref) => CreateSlidesNotifier(ref),
);
