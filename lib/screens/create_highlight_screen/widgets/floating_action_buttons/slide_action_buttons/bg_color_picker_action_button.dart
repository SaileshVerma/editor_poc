import 'package:drag_drop_editor_poc/providers/slides.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BgColorChangerActionButton extends ConsumerStatefulWidget {
  final String slideUniqueId;
  final Color textColor;
  final Color currentSlideBgColor;

  const BgColorChangerActionButton({
    required this.slideUniqueId,
    required this.textColor,
    required this.currentSlideBgColor,
    super.key,
  });

  @override
  ConsumerState<BgColorChangerActionButton> createState() =>
      _BgColorChangerActionButtonState();
}

class _BgColorChangerActionButtonState
    extends ConsumerState<BgColorChangerActionButton> {
  late Color selectedColor;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          isScrollControlled: true,
          builder: (ctx) {
            return SingleChildScrollView(
              child: Container(
                height: 400,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 8.0,
                      ),
                      child: Container(
                        width: 68,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: CustomColors.borderColor,
                        ),
                      ),
                    ),
                    FocusScope(
                      onFocusChange: ((focus) {
                        setState(() {
                          isFocused = focus;
                        });
                      }),
                      child: ColorPicker(
                        pickerColor: widget.currentSlideBgColor,
                        onColorChanged: (color) {
                          ref
                              .read(createSlideProvider.notifier)
                              .updateSlideColor(
                                backgroundColor: color,
                                slideUniqueId: widget.slideUniqueId,
                              );
                        },
                        enableAlpha: false,
                        hexInputBar: true,
                        pickerAreaHeightPercent: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).whenComplete(() {
          setState(() {
            isFocused = false;
          });
        });
      },
      child: Icon(
        Icons.color_lens,
        size: 32,
        color: widget.textColor,
      ),
    );
  }
}
