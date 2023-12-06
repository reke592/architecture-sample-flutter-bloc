import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/bloc/issue_overview_bloc.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_report.dart';

part 'issue_list_event.dart';
part 'issue_list_state.dart';

class IssueListBloc extends Bloc<IssueListEvent, IssueListState> {
  final IssueRepository _repo;
  late final StreamSubscription<IssueOverviewEvent> _issueOverviewEventListener;

  IssueListBloc({required IssueRepository repo})
      : _repo = repo,
        super(const IssueListState()) {
    on<LoadIssues>(_onLoadIssues);
    on<AddNewItem>(_onAddNewItem);
    on<ReplaceExistingItem>(_onReplaceExistingItem);
    _issueOverviewEventListener = _repo.getIssueOverviewEvent().listen((event) {
      if (event is IssueSubmitted) {
        if (event.isNewRecord) {
          add(AddNewItem(event.value));
        } else {
          add(ReplaceExistingItem(event.value));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await _issueOverviewEventListener.cancel();
    return super.close();
  }

  FutureOr<void> _onLoadIssues(
    LoadIssues event,
    Emitter<IssueListState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final data = await _repo.getIssues();
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event));
      rethrow;
    }
  }

  FutureOr<void> _onAddNewItem(
    AddNewItem event,
    Emitter<IssueListState> emit,
  ) {
    emit(state.success(
      event,
      List<IssueReport>.from(state.data)..add(event.value),
    ));
  }

  FutureOr<void> _onReplaceExistingItem(
    ReplaceExistingItem event,
    Emitter<IssueListState> emit,
  ) {
    final index =
        state.data.indexWhere((element) => element.id == event.value.id);
    if (index > -1) {
      final updated = List<IssueReport>.from(state.data);
      updated[index] = event.value;
      emit(state.success(event, updated));
    }
  }
}
