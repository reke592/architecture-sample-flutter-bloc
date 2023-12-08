part of 'text_selection_bloc.dart';

@immutable
abstract class TextSelectionEvent {}

class TextSelectionUpdate extends TextSelectionEvent {
  final String value;
  final Object? source;
  TextSelectionUpdate(this.value, [this.source]);
}

class AcceptSelectionData extends TextSelectionEvent {}

class ClearSelectionData extends TextSelectionEvent {}
