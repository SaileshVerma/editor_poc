import 'dart:io';
import 'package:drag_drop_editor_poc/models/slide_content_media.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/drag_to_delete_drop_target_widget.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/slide_content_image_holder.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class DraggableResizableSlideImage extends ConsumerStatefulWidget {
  final String slideTempUniqueId;
  final Color textColor;
  final SlideImageContent? slideImageContentObject;

  const DraggableResizableSlideImage({
    required this.slideTempUniqueId,
    required this.textColor,
    this.slideImageContentObject,
    super.key,
  });

  @override
  ConsumerState<DraggableResizableSlideImage> createState() =>
      _DraggableResizableSlideImageState();
}

class _DraggableResizableSlideImageState
    extends ConsumerState<DraggableResizableSlideImage> {
  double scaleFactor = 1;
  double xUnit = 0;
  double yUnit = 0;

  @override
  void initState() {
    scaleFactor = widget.slideImageContentObject?.scaleFactor ?? 1;

    xUnit = widget.slideImageContentObject?.offsetXUnit ?? 0;
    yUnit = widget.slideImageContentObject?.offsetYUnit ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Positioned(
      left: xUnit * width,
      top: yUnit * height,
      child: LongPressDraggable(
        delay: const Duration(milliseconds: 90),
        data: widget.slideImageContentObject?.id ?? '',
        maxSimultaneousDrags: 1,
        onDragEnd: (details) {
          ref.read(toShowTheDragDeleteIconProvider.notifier).state = false;
        },
        onDragUpdate: (details) {
          ref.read(toShowTheDragDeleteIconProvider.notifier).state = true;
          setState(() {
            xUnit = (((xUnit * width) + details.delta.dx)) / width;
            yUnit = (((yUnit * height) + details.delta.dy)) / height;
          });

          ref
              .read(slideImageContentStateProvider(widget.slideTempUniqueId)
                  .notifier)
              .updateImageOffset(
                id: widget.slideImageContentObject?.id ?? '',
                xUnit: xUnit,
                yUnit: yUnit,
              );
        },
        feedback: Material(
          color: Colors.transparent,
          child: SlideContentImageHolder(
            uid: widget.slideImageContentObject?.id ?? '',
            imageHolderDimension:
                widget.slideImageContentObject?.imageContainerDimension ?? 1,
            imageUrl: widget.slideImageContentObject?.slideMedia ?? '',
            scaleFactor: scaleFactor,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: SlideContentImageHolder(
            uid: widget.slideImageContentObject?.id ?? '',
            imageHolderDimension:
                widget.slideImageContentObject?.imageContainerDimension ?? 1,
            imageUrl: widget.slideImageContentObject?.slideMedia ?? '',
            scaleFactor: scaleFactor,
          ),
        ),
        child: Container(
          color: Colors.transparent,
          height: height,
          width: width,
          child: PhotoView.customChild(
            basePosition: Alignment.topLeft,
            tightMode: true,
            enablePanAlways: false,
            heroAttributes: PhotoViewHeroAttributes(
                tag: "tag${widget.slideImageContentObject?.id ?? ''}"),
            initialScale: scaleFactor,
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            onScaleEnd: (ctx, value, details) {
              setState(() {
                scaleFactor = (details.scale ?? 1);
              });
              ref
                  .read(slideImageContentStateProvider(widget.slideTempUniqueId)
                      .notifier)
                  .updateMultiplier(
                    id: widget.slideImageContentObject?.id ?? '',
                    scaleMultiplier: scaleFactor,
                  );
            },
            child: SizedBox(
              height: height * 0.3 * scaleFactor,
              width: height * 0.3 * scaleFactor,
              child: Image.file(
                File(widget.slideImageContentObject?.slideMedia ?? ''),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
