part of 'text_selection_bloc.dart';

@immutable
class TextSelectionState extends Equatable {
  final TextSelectionEvent? action;
  final Object? source;
  final String text;

  const TextSelectionState({
    this.action,
    this.source,
    this.text = '',
  });

  bool get isNotEmpty => text.trim().isNotEmpty;

  @override
  List<Object?> get props => [text, action, source];

  TextSelectionState copyWith({
    required TextSelectionEvent action,
    String? text,
    Object? Function()? source,
  }) =>
      TextSelectionState(
        action: action,
        text: text ?? this.text,
        source: source != null ? source() : this.source,
      );
}
