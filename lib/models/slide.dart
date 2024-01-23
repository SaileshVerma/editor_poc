import 'package:drag_drop_editor_poc/models/slide_content_media.dart';
import 'package:drag_drop_editor_poc/models/slide_content_text.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Slide extends Equatable {
  final String? id;
  final String? tempUniqueId;
  final Color? backgroundColor;
  final String? createdAt;
  final String? updatedAt;
  final List<SlideTextContent>? slideContentTexts;
  final List<SlideImageContent>? slideContentImages;
  final String? slideLayoutImageUrl;

  const Slide({
    this.id,
    this.tempUniqueId,
    this.backgroundColor,
    this.createdAt,
    this.updatedAt,
    this.slideContentTexts,
    this.slideContentImages,
    this.slideLayoutImageUrl,
  });

  Slide copyWith({
    String? id,
    String? tempUniqueId,
    Color? backgroundColor,
    String? createdAt,
    String? updatedAt,
    List<SlideTextContent>? slideContentTexts,
    List<SlideImageContent>? slideContentImages,
    String? slideLayoutImageUrl,
  }) {
    return Slide(
      id: id ?? this.id,
      tempUniqueId: tempUniqueId ?? this.tempUniqueId,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      slideContentTexts: slideContentTexts ?? this.slideContentTexts,
      slideContentImages: slideContentImages ?? this.slideContentImages,
      slideLayoutImageUrl: slideLayoutImageUrl ?? this.slideLayoutImageUrl,
    );
  }

  static const empty = Slide();

  factory Slide.fromJson({required Map<String, dynamic>? json}) {
    if (json == null) {
      return Slide.empty;
    }

    List<dynamic> jsonSlideContentImages = json['slideContentMedia'] ?? [];
    List<dynamic> jsonSlideContentTexts = json['slideContentText'] ?? [];

    List<SlideImageContent> slideImagesContent = [];
    List<SlideTextContent> slideTextsContent = [];

    for (final item in jsonSlideContentTexts) {
      slideTextsContent.add(
        SlideTextContent.fromJson(
          json: item,
        ),
      );
    }

    for (final item in jsonSlideContentImages) {
      slideImagesContent.add(
        SlideImageContent.fromJson(
          json: item,
        ),
      );
    }

    final slide = Slide(
      tempUniqueId: json['tempUniqueId'],
      id: json['id'],
      backgroundColor:
          convertHexStringToColorType(hexStr: json['backgroundColor']),
      slideLayoutImageUrl: json['slideLayoutImageUrl'], //TODO: update this
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      slideContentImages: slideImagesContent,
      slideContentTexts: slideTextsContent,
    );

    return slide;
  }

  Map<String, dynamic> toJson() {
    List<dynamic> jsonInputSlideContentMedias = [];
    slideContentImages?.forEach((element) {
      jsonInputSlideContentMedias.add(element.toMap());
    });

    List<dynamic> jsonInputSlideContentTexts = [];
    slideContentTexts?.forEach((element) {
      jsonInputSlideContentTexts.add(element.toMap());
    });

    return {
      'id': id,
      'tempUniqueId': tempUniqueId,
      'slideContentMedia': jsonInputSlideContentMedias,
      'slideContentText': jsonInputSlideContentTexts,
      'backgroundColor': backgroundColor?.value
          .toRadixString(16)
          .substring(2), //store hex value
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List get props => [
        id,
        tempUniqueId,
        backgroundColor,
        createdAt,
        updatedAt,
        slideContentTexts,
        slideContentImages,
        slideLayoutImageUrl,
      ];
}

Color convertHexStringToColorType({required String? hexStr}) {
  if (hexStr == null) {
    return const Color.fromARGB(0, 255, 255, 255);
  }
  final hexCode = int.tryParse('0xff$hexStr');
  return Color(hexCode ?? 0xffffffff);
}
