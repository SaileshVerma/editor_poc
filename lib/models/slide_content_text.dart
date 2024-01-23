import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:drag_drop_editor_poc/utils/helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SlideTextContent extends Equatable {
  final String? id;
  final String? text;
  final FontFamily? fontFamily;
  final TextAlignment? textAlignment;
  final TextFontStyle? textFontStyle;
  final int? fontWeight;
  final Color? textBackgroundColor;
  final double? fontSize;
  final double offsetXUnit;
  final double offsetYUnit;
  final double scaleFactor;
  final bool? toUpperCase;
  final Color? textColor;

  const SlideTextContent({
    required this.id,
    required this.text,
    required this.fontSize,
    required this.offsetXUnit,
    required this.offsetYUnit,
    required this.scaleFactor,
    this.fontFamily,
    this.textAlignment,
    this.textFontStyle,
    this.fontWeight,
    this.textBackgroundColor,
    this.toUpperCase,
    this.textColor,
  });

  static const empty = SlideTextContent(
    id: '',
    text: '',
    fontSize: 16.0,
    offsetXUnit: 0.0,
    offsetYUnit: 0.0,
    scaleFactor: 1.0,
  );

  SlideTextContent copyWith({
    String? id,
    String? text,
    FontFamily? fontFamily,
    TextFontStyle? textFontStyle,
    int? fontWeight,
    TextAlignment? textAlignment,
    Color? textBackgroundColor,
    double? fontSize,
    double? offsetXUnit,
    double? offsetYUnit,
    double? scaleFactor,
    bool? toUpperCase,
    Color? textColor,
  }) {
    return SlideTextContent(
      id: id ?? this.id,
      text: text ?? this.text,
      fontFamily: fontFamily ?? this.fontFamily,
      textFontStyle: textFontStyle ?? this.textFontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      textBackgroundColor: textBackgroundColor ?? this.textBackgroundColor,
      fontSize: fontSize ?? this.fontSize,
      textAlignment: textAlignment ?? this.textAlignment,
      offsetXUnit: offsetXUnit ?? this.offsetXUnit,
      offsetYUnit: offsetYUnit ?? this.offsetYUnit,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      toUpperCase: toUpperCase ?? this.toUpperCase,
      textColor: textColor ?? this.textColor,
    );
  }

  factory SlideTextContent.fromJson({
    required Map<String, dynamic>? json,
  }) {
    if (json == null) {
      return SlideTextContent.empty;
    }

    return SlideTextContent(
      id: json['id'],
      text: json['text'],
      fontFamily: json['fontFamily'].runtimeType == String
          ? FontFamily.values.byName(json['fontFamily'])
          : FontFamily.DISPLAY,
      textFontStyle: json['fontStyle'].runtimeType == String
          ? TextFontStyle.values.byName(json['fontStyle'])
          : TextFontStyle.REGULAR,
      fontWeight: json['fontWeight'],
      textBackgroundColor:
          convertHexStringToColorType(hexStr: json['textBackgroundColor']),
      textAlignment: json['textAlignment'].runtimeType == String
          ? TextAlignment.values.byName(json['textAlignment'])
          : TextAlignment.CENTER,
      fontSize: double.tryParse((json['fontSize']).toString()),
      offsetXUnit: json['offsetXUnit'],
      offsetYUnit: json['offsetYUnit'],
      scaleFactor: double.tryParse((json['scaleFactor']).toString()) ?? 1.0,
      textColor: convertHexStringToColorType(hexStr: json['textColor']),
    );
  }

  Map toMap() => {
        'id': id,
        'text': text,
        'textBackgroundColor':
            textBackgroundColor?.value.toRadixString(16).substring(2),
        'fontSize': fontSize,
        'offsetXUnit': offsetXUnit,
        'offsetYUnit': offsetYUnit,
        'fontFamily':
            fontFamily?.toString().split('.').last ?? FontFamily.DISPLAY.name,
        'fontStyle': textFontStyle?.toString().split('.').last ??
            TextFontStyle.REGULAR.name,
        'fontWeight': fontWeight,
        'textAlignment': textAlignment?.toString().split('.').last ??
            TextAlignment.CENTER.name,
        'toUpperCase': toUpperCase,
        'textColor':
            textColor?.value.toRadixString(16).substring(2) ?? '000000',
      };

  @override
  List get props => [
        id,
        text,
        fontFamily,
        textAlignment,
        textFontStyle,
        fontWeight,
        textBackgroundColor,
        fontSize,
        offsetXUnit,
        offsetYUnit,
        scaleFactor,
        toUpperCase,
        textColor,
      ];
}
