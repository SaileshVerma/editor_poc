import 'package:drag_drop_editor_poc/screens/create_highlight_screen/create_highlight_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SlidesIndicator extends ConsumerWidget {
  final int slidesLength;
  final Color textColor;
  final int currentPageIndex;

  const SlidesIndicator({
    required this.slidesLength,
    required this.textColor,
    required this.currentPageIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentCarouselIndex);

    return slidesLength > 10
        ? ScrollSlideIndicator(
            slidesLength: slidesLength,
            textColor: textColor,
            index: index,
          )
        : RectangleSlideIndicator(
            slidesLength: slidesLength,
            textColor: textColor,
            index: index,
          );
  }
}

class ScrollSlideIndicator extends ConsumerWidget {
  final int slidesLength;
  final Color textColor;
  final int index;

  const ScrollSlideIndicator({
    required this.slidesLength,
    required this.textColor,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      height: 16,
      child: Center(
        child: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: ref.watch(createSlidesScrollController),
            itemExtent: 16,
            diameterRatio: 1.5,
            perspective: 0.003,
            children: List.generate(
              slidesLength,
              (i) {
                return AutoScrollTag(
                  controller: ref.watch(createSlidesScrollController),
                  key: ValueKey(i),
                  index: i,
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    color: textColor.withOpacity(
                      index == i ? 1 : 0.5,
                    ),
                    height: 14,
                    width: 14,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RectangleSlideIndicator extends StatelessWidget {
  final int slidesLength;
  final Color textColor;
  final int index;

  const RectangleSlideIndicator({
    required this.slidesLength,
    required this.textColor,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 10,
      child: Center(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: slidesLength,
          itemBuilder: (ctx, i) => Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 100,
              ),
              color: textColor.withOpacity(index == i ? 1 : 0.5),
              height: 10,
              width: 10,
            ),
          ),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

final createSlidesScrollController = StateProvider(
  (ref) => AutoScrollController(
    viewportBoundaryGetter: () => const Rect.fromLTRB(0, 0, 0, 0),
    axis: Axis.horizontal,
  ),
);
