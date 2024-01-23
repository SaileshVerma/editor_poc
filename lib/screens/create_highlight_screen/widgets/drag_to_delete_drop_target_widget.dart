import 'package:drag_drop_editor_poc/providers/slide_content_images.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DragToDeleteDropTargetWidget extends ConsumerStatefulWidget {
  final String uniqueId;
  final Color textColor;

  const DragToDeleteDropTargetWidget({
    required this.uniqueId,
    required this.textColor,
    super.key,
  });

  @override
  ConsumerState<DragToDeleteDropTargetWidget> createState() =>
      _DragToDeleteDropTargetWidgetState();
}

class _DragToDeleteDropTargetWidgetState
    extends ConsumerState<DragToDeleteDropTargetWidget> {
  bool willAccept = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Visibility(
        visible: ref.watch(toShowTheDragDeleteIconProvider),
        child: DragTarget<String>(
          onWillAccept: (data) {
            setState(() {
              willAccept = true;
            });

            return true;
          },
          onLeave: (data) {
            setState(() {
              willAccept = false;
            });
          },
          onAccept: (data) {
            setState(() {
              willAccept = false;
            });

            ref
                .read(slideImageContentStateProvider(
                  widget.uniqueId,
                ).notifier)
                .deleteSlideContentImageObject(
                  id: data,
                );

            ref.read(currentlySelectedSlideContentTextItemId.notifier).state =
                '';
          },
          builder: (ctx, accepted, rejected) {
            return Container(
              height: MediaQuery.of(context).size.width * 0.24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: willAccept
                        ? CustomColors.error.withOpacity(0.3)
                        : widget.textColor.withOpacity(0.09),
                    spreadRadius: 2,
                    blurRadius: 20,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.2,
              child: Opacity(
                opacity: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Drag to delete',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.textColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final toShowTheDragDeleteIconProvider = StateProvider((ref) => false);
