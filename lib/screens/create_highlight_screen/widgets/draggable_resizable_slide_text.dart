import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/slide_content_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DraggableResizableSlideText extends ConsumerStatefulWidget {
  final String slideTempUniqueId;
  final Color textColor;
  final BoxConstraints constraints;
  final SlideTextContent? slideTextObject;

  const DraggableResizableSlideText({
    required this.slideTempUniqueId,
    required this.textColor,
    required this.constraints,
    this.slideTextObject,
    super.key,
  });

  @override
  ConsumerState<DraggableResizableSlideText> createState() =>
      _DraggableResizableSlideTextState();
}

class _DraggableResizableSlideTextState
    extends ConsumerState<DraggableResizableSlideText> {
  double scaleFactor = 1;
  late double xUnit;
  late double yUnit;

  @override
  void initState() {
    scaleFactor = widget.slideTextObject?.scaleFactor ?? 1;
    xUnit = widget.slideTextObject?.offsetXUnit ?? 0;
    yUnit = widget.slideTextObject?.offsetYUnit ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Positioned(
      left: xUnit * width,
      top: yUnit * height,
      child: Draggable(
        data: widget.slideTextObject?.id ?? '',
        maxSimultaneousDrags: 1,
        onDragUpdate: (details) {
          ref.read(currentlySelectedSlideContentTextItemId.notifier).state =
              widget.slideTextObject?.id ?? '';

          setState(() {
            xUnit = (((xUnit * width) + details.delta.dx)) / width;
            yUnit = (((yUnit * height) + details.delta.dy)) / height;
          });

          ref
              .read(slideTextContentStateProvider(widget.slideTempUniqueId)
                  .notifier)
              .updateTextOffset(
                id: widget.slideTextObject?.id ?? '',
                xUnit: xUnit,
                yUnit: yUnit,
              );
        },
        feedback: Material(
          color: Colors.transparent,
          child: SlideContentTextWithObjectWidget(
            slideTextObject: widget.slideTextObject,
            slideTempUniqueId: widget.slideTempUniqueId,
            scaleFactor: scaleFactor,
            textColor: widget.textColor,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: SlideContentTextWithObjectWidget(
            slideTempUniqueId: widget.slideTempUniqueId,
            slideTextObject: widget.slideTextObject,
            scaleFactor: scaleFactor,
            textColor: widget.textColor,
          ),
        ),
        child: SlideContentTextWithObjectWidget(
          slideTempUniqueId: widget.slideTempUniqueId,
          slideTextObject: widget.slideTextObject,
          scaleFactor: scaleFactor,
          textColor: widget.textColor,
        ),
      ),
    );
  }
}

final currentlySelectedSlideContentTextItemId = StateProvider((ref) => '');
