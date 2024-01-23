import 'package:drag_drop_editor_poc/models/slide.dart';
import 'package:equatable/equatable.dart';

class SlidesState extends Equatable {
  final String highlightId;
  final List<Slide> slides;

  const SlidesState({
    required this.highlightId,
    required this.slides,
  });

  static final empty = SlidesState(highlightId: '', slides: []);

  SlidesState copyWith({
    String? highlightId,
    List<Slide>? slides,
  }) {
    return SlidesState(
      highlightId: highlightId ?? this.highlightId,
      slides: slides ?? this.slides,
    );
  }

  @override
  List get props => [
        highlightId,
        slides,
      ];
}
