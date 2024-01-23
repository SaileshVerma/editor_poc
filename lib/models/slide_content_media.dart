import 'package:equatable/equatable.dart';

class SlideImageContent extends Equatable {
  final String? id;
  final String? slideMedia;
  final double? imageContainerDimension;
  final double offsetXUnit;
  final double offsetYUnit;
  final double scaleFactor;

  const SlideImageContent({
    required this.id,
    required this.slideMedia,
    required this.imageContainerDimension,
    required this.offsetXUnit,
    required this.offsetYUnit,
    required this.scaleFactor,
  });

  static const empty = SlideImageContent(
    id: '',
    slideMedia: '',
    imageContainerDimension: 16.0,
    offsetXUnit: 0.0,
    offsetYUnit: 0.0,
    scaleFactor: 1.0,
  );

  SlideImageContent copyWith({
    String? id,
    String? slideMedia,
    double? imageContainerDimension,
    double? offsetXUnit,
    double? offsetYUnit,
    double? scaleFactor,
  }) {
    return SlideImageContent(
      id: id ?? this.id,
      slideMedia: slideMedia ?? this.slideMedia,
      imageContainerDimension:
          imageContainerDimension ?? this.imageContainerDimension,
      offsetXUnit: offsetXUnit ?? this.offsetXUnit,
      offsetYUnit: offsetYUnit ?? this.offsetYUnit,
      scaleFactor: scaleFactor ?? this.scaleFactor,
    );
  }

  factory SlideImageContent.fromJson({required Map<String, dynamic>? json}) {
    if (json == null) {
      return SlideImageContent.empty;
    }

    return SlideImageContent(
      id: json['id'],
      slideMedia: json['slideMedia'],
      imageContainerDimension:
          double.tryParse((json['imageContainerDimension']).toString()) ??
              100.0,
      offsetXUnit: json['offsetXUnit'],
      offsetYUnit: json['offsetYUnit'],
      scaleFactor: double.tryParse((json['scaleFactor']).toString()) ?? 1.0,
    );
  }

  Map toMap() => {
        'id': id,
        'slideMedia': slideMedia,
        'imageContainerDimension': imageContainerDimension.toString(),
        'offsetXUnit': offsetXUnit.toString(),
        'offsetYUnit': offsetYUnit.toString(),
        'scaleFactor': scaleFactor.toString(),
      };

  @override
  List get props => [
        id,
        slideMedia,
        imageContainerDimension,
        offsetXUnit,
        offsetYUnit,
        scaleFactor,
      ];
}
