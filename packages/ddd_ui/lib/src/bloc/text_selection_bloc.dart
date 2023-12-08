import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';

part 'text_selection_event.dart';
part 'text_selection_state.dart';

class TextSelectionBloc extends Bloc<TextSelectionEvent, TextSelectionState> {
  TextSelectionBloc() : super(const TextSelectionState()) {
    on<TextSelectionUpdate>(_onTextSelectionUpdate);
    on<AcceptSelectionData>(_onAcceptSelectionData);
    on<ClearSelectionData>(_onClearSelectionData);
  }

  FutureOr<void> _onTextSelectionUpdate(
    TextSelectionUpdate event,
    Emitter<TextSelectionState> emit,
  ) {
    emit(state.copyWith(
      action: event,
      text: event.value,
      source: () => event.source,
    ));
  }

  FutureOr<void> _onAcceptSelectionData(
    AcceptSelectionData event,
    Emitter<TextSelectionState> emit,
  ) {
    emit(state.copyWith(action: event));
  }

  FutureOr<void> _onClearSelectionData(
    ClearSelectionData event,
    Emitter<TextSelectionState> emit,
  ) {
    emit(const TextSelectionState());
  }
}
