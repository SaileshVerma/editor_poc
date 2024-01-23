import 'package:drag_drop_editor_poc/models/slide_content_media.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideImagesContentStateNotifier
    extends StateNotifier<List<SlideImageContent>> {
  SlideImagesContentStateNotifier(this.ref) : super([]);

  Ref ref;

  void addInitialImageToStateList({
    required String imageUrl,
  }) {
    if (imageUrl.isEmpty) {
      return;
    }
    final newList = state;

    const newOffset = Offset(0.2, 0.2);

    newList.add(
      SlideImageContent(
        id: '${DateTime.now()}imgs@@@@@@@',
        offsetXUnit: newOffset.dx,
        offsetYUnit: newOffset.dy,
        scaleFactor: 1.0,
        slideMedia: imageUrl,
        imageContainerDimension: 100.0, //TODO: chnage intial image size,
      ),
    );

    state = [...newList];
  }

  void updateMultiplier({
    required String id,
    required double scaleMultiplier,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    final updatedItem = item.copyWith(
      scaleFactor: scaleMultiplier,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateImageOffset({
    required String id,
    required double xUnit,
    required double yUnit,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      offsetXUnit: xUnit,
      offsetYUnit: yUnit,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  // void addTextToStateList({required SlideTextContent slideTextContentObj}) {
  //   final newList = state;
  //   newList.add(slideTextContentObj);
  //   state = [...newList];
  // }

  void deleteSlideContentImageObject({
    required String id,
  }) {
    final newList = state;
    newList.removeWhere((element) => element.id == id);

    state = [...newList];
  }

  void resetState() {
    ref.invalidate(slideImageContentStateProvider);
  }

  void clearCurrentFamilyState() {
    state = [];
  }

  void updateStateToNewImages({
    required List<SlideImageContent> slideImageContents,
  }) {
    state = [...slideImageContents];
  }
}

final slideImageContentStateProvider = StateNotifierProvider.family<
    SlideImagesContentStateNotifier, List<SlideImageContent>, String>(
  (ref, arg) => SlideImagesContentStateNotifier(ref),
);
