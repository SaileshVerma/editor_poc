import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopySlideTextActionIcon extends StatefulWidget {
  const CopySlideTextActionIcon({
    required this.currentSelectedTextObject,
    super.key,
  });

  final SlideTextContent currentSelectedTextObject;

  @override
  State<CopySlideTextActionIcon> createState() =>
      _CopySlideTextActionIconState();
}

class _CopySlideTextActionIconState extends State<CopySlideTextActionIcon> {
  bool isCopied = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.backgroundColor,
      child: Column(
        children: [
          IconButton(
            highlightColor: CustomColors.secondaryBlueBackgroundFill,
            splashColor: CustomColors.secondaryBlue,
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: widget.currentSelectedTextObject.text ?? '',
                ),
              ).then(
                (_) async {
                  setState(() {
                    isCopied = true;
                  });

                  await Future.delayed(const Duration(milliseconds: 400));

                  // NavigationKeys.getGlobalKeyCurrentState?.pop();
                },
              );
            },
            icon: Icon(
              Icons.copy,
              color: isCopied
                  ? CustomColors.secondaryBlue
                  : CustomColors.greyDark1,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.bounceIn,
            child: isCopied
                ? const Text(
                    'Copied',
                    style: TextStyle(
                      color: CustomColors.secondaryBlue,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : const Text(
                    'Copy',
                    style: TextStyle(
                      color: CustomColors.greyDark1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
