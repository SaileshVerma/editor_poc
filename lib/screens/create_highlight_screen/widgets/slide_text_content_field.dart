import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/create_highlight_screen.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideTextContentField extends ConsumerStatefulWidget {
  final Color textColor;
  final String uid;
  final bool isUpperCased;
  final SlideTextContent? slideContentObject;

  const SlideTextContentField({
    required this.textColor,
    required this.uid,
    required this.isUpperCased,
    this.slideContentObject,
    super.key,
  });

  @override
  ConsumerState<SlideTextContentField> createState() =>
      _SlideTextContentFieldState();
}

class _SlideTextContentFieldState extends ConsumerState<SlideTextContentField> {
  late TextEditingController textEditingController;
  scrollToBottom() {
    ref.read(scrollControllerProvider).animateTo(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
        ref.read(scrollControllerProvider).positions.last.maxScrollExtent);
  }

  @override
  void initState() {
    textEditingController = TextEditingController(
      text: widget.isUpperCased
          ? (widget.slideContentObject?.text ?? '').toUpperCase()
          : widget.slideContentObject?.text ?? '',
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlideTextContentField oldWidget) {
    setState(() {});
    textEditingController.text = widget.isUpperCased
        ? (widget.slideContentObject?.text ?? '').toUpperCase()
        : widget.slideContentObject?.text ?? '';
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideContentObject = ref
        .read(slideTextContentStateProvider(widget.uid).notifier)
        .getCurrentSelectedSlideTextObjectById(
          id: widget.slideContentObject?.id ?? "",
        );

    final height = MediaQuery.of(context).size.height;
    final keyPadBottomPadding = (MediaQuery.of(context).size.height * 0.47);
    final toAddPaddingAtBottomText =
        (((widget.slideContentObject?.offsetYUnit ?? 1) * height) >
            keyPadBottomPadding);

    return TextFormField(
      key: ValueKey(widget.slideContentObject?.id ?? ''),
      controller: textEditingController,
      cursorWidth: 0.7,
      enableInteractiveSelection: false,

      autofocus: ref.watch(toSetAutoFocusBoolStateProvider),
      maxLength: 40,
      maxLines: null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: widget.textColor,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      // initialValue:
      //     // ? (slideContentObject.text ?? '').toUpperCase()
      //     slideContentObject.text ?? '',
      style: TextStyle(
        fontWeight: slideContentObject.textFontStyle == TextFontStyle.BOLD
            ? FontWeight.w600
            : FontWeight.w400,
        color: slideContentObject.textColor ?? widget.textColor,
        fontSize: 16,
        decorationColor: slideContentObject.textColor ?? widget.textColor,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        counterText: '',
        hintText: 'TEXT',
        hintStyle: TextStyle(
          color: widget.textColor.withOpacity(0.5),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
      ),
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
        ref.read(scrollControllerProvider).animateTo(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 100),
              0.0,
            );
        ref.read(toSetAutoFocusBoolStateProvider.notifier).state = false;
      },
      onTap: () {
        ref.read(currentlySelectedSlideContentTextItemId.notifier).state =
            slideContentObject.id ?? '';
        if (toAddPaddingAtBottomText) {
          scrollToBottom();
        }
      },
      onChanged: (str) {
        final currentSelectedSlideTextId =
            ref.watch(currentlySelectedSlideContentTextItemId);
        ref
            .read(slideTextContentStateProvider(widget.uid).notifier)
            .onChangedSlideContentTextUpdated(
              id: currentSelectedSlideTextId,
              str: str,
            );
      },
      onFieldSubmitted: (text) {
        ref.read(scrollControllerProvider).animateTo(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 10),
              0.0,
            );
        ref.read(toSetAutoFocusBoolStateProvider.notifier).state = false;
        FocusManager.instance.primaryFocus?.unfocus();

        textEditingController.clear();
      },
    );
  }
}

final toSetAutoFocusBoolStateProvider = StateProvider((ref) => false);
