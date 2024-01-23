import 'package:drag_drop_editor_poc/providers/slide_content_texts.dart';
import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextBgColorPicker extends ConsumerStatefulWidget {
  final String slideUniqueId;
  final String currentSelectedTextObjectId;
  final Color textColor;
  final Color currentTextBgColor;

  const TextBgColorPicker({
    required this.slideUniqueId,
    required this.currentSelectedTextObjectId,
    required this.textColor,
    required this.currentTextBgColor,
    super.key,
  });

  @override
  ConsumerState<TextBgColorPicker> createState() => _TextBgColorPickerState();
}

class _TextBgColorPickerState extends ConsumerState<TextBgColorPicker> {
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
                          pickerColor:
                              widget.currentTextBgColor == Colors.transparent
                                  ? getTextColorForBackground(widget.textColor)
                                  : widget.currentTextBgColor,
                          onColorChanged: (color) {
                            ref
                                .read(slideTextContentStateProvider(
                                        widget.slideUniqueId)
                                    .notifier)
                                .updateTextBackgroundColor(
                                  id: widget.currentSelectedTextObjectId,
                                  textBackgroundColor: color,
                                );
                          },
                          paletteType: PaletteType.hslWithHue,
                          displayThumbColor: true,
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
          Icons.color_lens_outlined,
          size: 32,
          color: widget.textColor,
        ));
  }
}
