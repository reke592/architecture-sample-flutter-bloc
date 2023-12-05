import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_report.dart';

part 'issue_list_event.dart';
part 'issue_list_state.dart';

class IssueListBloc extends Bloc<IssueListEvent, IssueListState> {
  final IssueRepository _repo;

  IssueListBloc({required IssueRepository repo})
      : _repo = repo,
        super(const IssueListState()) {
    on<LoadIssues>(_onLoadIssues);
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
}
