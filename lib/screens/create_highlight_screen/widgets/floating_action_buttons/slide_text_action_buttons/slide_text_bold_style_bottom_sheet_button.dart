import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class SlideTextBoldStyleBottomSheetButton extends StatelessWidget {
  final String slideTempUniqueId;
  final Color textColor;
  final SlideTextContent currentSelectedTextObject;

  const SlideTextBoldStyleBottomSheetButton({
    required this.currentSelectedTextObject,
    required this.slideTempUniqueId,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(Icons.abc),
      onTap: () {
        showModalBottomSheet(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.white,
          barrierColor: Colors.transparent,
          context: context,
          builder: (ctx) {
            return IntrinsicHeight(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Container(
                      width: 68,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: CustomColors.borderColor,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //   height: 80,
                  //   child: TextFontStyleActionButtonsWidget(
                  //     textFontStyle: currentSelectedTextObject.textFontStyle ??
                  //         TextFontStyle.REGULAR,
                  //     uid: slideTempUniqueId,
                  //     isUpperCased:
                  //         currentSelectedTextObject.toUpperCase ?? false,
                  //   ),
                  // ),
                  const Divider(
                    color: CustomColors.dividerColor,
                    endIndent: 24.0,
                    indent: 24.0,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //   height: 80,
                  //   child: TextAlignActionWidget(
                  //     textAlignment: currentSelectedTextObject.textAlignment ??
                  //         TextAlignment.CENTER,
                  //     uid: slideTempUniqueId,
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
