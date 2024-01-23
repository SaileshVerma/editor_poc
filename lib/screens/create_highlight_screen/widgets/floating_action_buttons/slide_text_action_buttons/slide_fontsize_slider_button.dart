import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/screens/create_highlight_screen/widgets/draggable_resizable_slide_text.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlideFontSizeSliderButton extends ConsumerWidget {
  final SlideTextContent currentSelectedTextObject;
  final String slideTempUniqueId;
  final Color textColor;

  const SlideFontSizeSliderButton({
    required this.currentSelectedTextObject,
    required this.slideTempUniqueId,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxSize = 200.0;
    const minSize = 5.0;
    return InkWell(
      onTap: () {
        double currentFontSize = currentSelectedTextObject.fontSize ?? 18;
        showModalBottomSheet(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          enableDrag: true,
          barrierColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (ctx) {
            return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) => Container(
                color: Colors.white,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.greyDark1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            valueIndicatorTextStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.greyDark1,
                            ),
                            valueIndicatorColor: Colors.amber,
                            showValueIndicator: ShowValueIndicator.always,
                            trackShape: RectangularSliderTrackShape(),
                          ),
                          child: Slider(
                            label: '${currentFontSize.toDouble().toInt()}',
                            inactiveColor:
                                CustomColors.mediumGrey2.withOpacity(0.5),
                            activeColor: CustomColors.greyDark1,
                            thumbColor: CustomColors.greyDark1,
                            min: minSize,
                            max: maxSize,
                            value: currentFontSize.toInt().toDouble(),
                            onChanged: (val) {
                              ref
                                  .read(slideTextContentStateProvider(
                                          slideTempUniqueId)
                                      .notifier)
                                  .updateFontSize(
                                    id: ref.watch(
                                        currentlySelectedSlideContentTextItemId),
                                    fontSize: val,
                                  );
                              setState(() {
                                currentFontSize = val;
                              });
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.greyDark1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Text(
        '${currentSelectedTextObject.fontSize?.roundToDouble().toInt()}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
      ),
    );
  }
}
