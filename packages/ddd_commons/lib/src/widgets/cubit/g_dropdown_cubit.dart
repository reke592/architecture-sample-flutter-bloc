import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';

part 'g_dropdown_state.dart';

/// {@template g_dropdown_cubit}
/// state logic for common  `GDropdown<T>` widget.
/// {@endtemplate}
class GDropdownCubit<T> extends Cubit<GDropdownState<T>> {
  final MessageBusRepository _repo;
  late final StreamSubscription<MessageBusResult> _resultListener;

  /// {@macro g_dropdown_cubit}
  GDropdownCubit({
    required MessageBusRepository repo,
  })  : _repo = repo,
        super(GDropdownState<T>()) {
    _resultListener = repo.getResults().listen((event) {
      if (event is ListResponse<T> &&
          event.request?.sender == state.request?.sender) {
        emit(state.success(event.data));
      }
    });
  }

  @override
  Future<void> close() {
    _resultListener.cancel();
    return super.close();
  }

  void load(ListRequest<T> request) {
    emit(state.loading(request));
    _repo.addEvent(request);
  }
}
