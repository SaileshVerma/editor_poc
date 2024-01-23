import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextColorPickerActionButton extends ConsumerStatefulWidget {
  final String currentSelectedTextObjectId;
  final String slideTempUniqueId;
  final Color textColor;
  final Color currentTextColor;

  const TextColorPickerActionButton({
    required this.currentSelectedTextObjectId,
    required this.slideTempUniqueId,
    required this.textColor,
    required this.currentTextColor,
    super.key,
  });

  @override
  ConsumerState<TextColorPickerActionButton> createState() =>
      _TextColorPickerActionButtonState();
}

class _TextColorPickerActionButtonState
    extends ConsumerState<TextColorPickerActionButton> {
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
                          pickerColor: widget.currentTextColor,
                          onColorChanged: (color) {
                            ref
                                .read(slideTextContentStateProvider(
                                        widget.slideTempUniqueId)
                                    .notifier)
                                .updateTextColor(
                                  id: widget.currentSelectedTextObjectId,
                                  textColor: color,
                                );
                          },
                          enableAlpha: false,
                          hexInputBar: true,
                          pickerAreaHeightPercent: 0.6,
                          paletteType: PaletteType.hslWithHue,
                          displayThumbColor: true,
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
        child: Icon(Icons.color_lens_sharp));
  }
}
