import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideTextContentStateNotifier
    extends StateNotifier<List<SlideTextContent>> {
  SlideTextContentStateNotifier(this.ref) : super([]);

  Ref ref;

  void addInitialTextToStateList({
    FontFamily? fontFamily,
    TextFontStyle? textFontStyle,
    int? fontWeight,
  }) {
    // if (text.isEmpty) {
    //   return;
    // }
    final newList = state;

    const newOffset = Offset(0.4, 0.4);

    final newTextItem = SlideTextContent(
      id: '${DateTime.now()}',
      fontSize: 18.0,
      offsetXUnit: newOffset.dx,
      offsetYUnit: newOffset.dy,
      text: '',
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      textFontStyle: textFontStyle,
      scaleFactor: 1.0,
    );

    newList.add(newTextItem);

    ref.read(currentlySelectedSlideContentTextItemId.notifier).state =
        newTextItem.id ?? '';

    state = [...newList];
  }

  String getCurrentSelectedSlideContentTextById({
    required String id,
  }) {
    final text = state.firstWhere((element) => element.id == id, orElse: () {
      return SlideTextContent.empty;
    });

    return text.text ?? '';
  }

  SlideTextContent getCurrentSelectedSlideTextObjectById({
    required String id,
  }) {
    final obj = state.firstWhere((element) => element.id == id, orElse: () {
      return SlideTextContent.empty;
    });

    return obj;
  }

  void toggleToUpperCase({
    required String id,
    required bool toUpperCase,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    final updatedItem = item.copyWith(
      toUpperCase: toUpperCase,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

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

  void updateFontSize({
    required String id,
    required double fontSize,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    final updatedItem = item.copyWith(
      fontSize: fontSize,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateTextOffset({
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

  void updateTextFontFamily({
    required String id,
    required FontFamily fontFamily,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(fontFamily: fontFamily);

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateSlideContentTextAlignment({
    required String id,
    required TextAlignment textAlignment,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(textAlignment: textAlignment);

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateSlideContentTextFontStyle({
    required String id,
    required TextFontStyle textFontStyle,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(textFontStyle: textFontStyle);

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void addTextToStateList({required SlideTextContent slideTextContentObj}) {
    final newList = state;
    newList.add(slideTextContentObj);
    state = [...newList];
  }

  void deleteSlideContentTextObject({
    required String id,
  }) {
    final newList = state;

    newList.removeWhere((element) => element.id == id);

    state = [...newList];
    ref.read(currentlySelectedSlideContentTextItemId.notifier).state = '';
    // ref.read(isCarouselScrollAllowed.notifier).state = true;
  }

  void onChangedSlideContentTextUpdated({
    required String id,
    required String str,
    bool? toCutText = false,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);

    final updatedItem = item.copyWith(
      text: str,
      textFontStyle:
          (toCutText ?? false) ? TextFontStyle.REGULAR : item.textFontStyle,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateTextBackgroundColor(
      {required String id, required Color textBackgroundColor}) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    final updatedItem = item.copyWith(
      textBackgroundColor: textBackgroundColor,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void updateTextColor({
    required String id,
    required Color textColor,
  }) {
    final newList = state;
    var item = newList.firstWhere((element) => element.id == id);
    final updatedItem = item.copyWith(
      textColor: textColor,
    );

    newList[newList.indexWhere((element) => element.id == id)] = updatedItem;

    state = [...newList];
  }

  void resetState() {
    ref.invalidate(slideTextContentStateProvider);
  }

  void duplicateTextObject({
    required String selectedTextToBeDuplicatedId,
  }) {
    final newList = state;

    SlideTextContent slideTextContent = newList.firstWhere(
      (element) => element.id == selectedTextToBeDuplicatedId,
    );
    final xUnit = slideTextContent.offsetXUnit + 0.04;
    final yUnit = slideTextContent.offsetYUnit + 0.04;

    final newOffset = Offset(xUnit, yUnit);

    slideTextContent = slideTextContent.copyWith(
      id: '${DateTime.now()}',
      offsetXUnit: newOffset.dx,
      offsetYUnit: newOffset.dy,
    );

    // final newTextItem = SlideTextContent(
    //   id: '${DateTime.now()}',
    //   fontSize: 18,
    //   offsetXUnit: newOffset.dx,
    //   offsetYUnit: newOffset.dy,
    //   text: '',
    //   fontFamily: fontFamily,
    //   fontWeight: fontWeight,
    //   textFontStyle: textFontStyle,
    //   scaleFactor: 1,
    //   rotation: 0.0,
    // );

    newList.add(slideTextContent);

    ref.read(currentlySelectedSlideContentTextItemId.notifier).state =
        slideTextContent.id ?? '';

    state = [...newList];
  }

  void updateStateToNewTexts({
    required List<SlideTextContent> slideTextContents,
  }) {
    state = [...slideTextContents];
  }

  void clearCurrentFamilyState() {
    state = [];
  }
}

final slideTextContentStateProvider = StateNotifierProvider.family<
    SlideTextContentStateNotifier, List<SlideTextContent>, String>(
  (ref, arg) => SlideTextContentStateNotifier(ref),
);
