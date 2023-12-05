import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/issue_report.dart';

part 'issue_overview_event.dart';
part 'issue_overview_state.dart';

class IssueOverviewBloc extends Bloc<IssueOverviewEvent, IssueOverviewState> {
  final IssueRepository _repo;

  IssueOverviewBloc({
    required IssueRepository repo,
    IssueReport? data,
  })  : _repo = repo,
        super(IssueOverviewState(data: data ?? const IssueReport())) {
    on<LoadComments>(_onLoadComments);
    on<SubmitIssue>(_onSubmitIssue, transformer: restartable());
  }

  FutureOr<void> _onLoadComments(
    LoadComments event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final comments = await _repo.getComments(state.data);
      emit(state.withComments(event, comments));
    } catch (error) {
      emit(state.failure(event));
      rethrow;
    }
  }

  FutureOr<void> _onSubmitIssue(
    SubmitIssue event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final isNewRecord = state.data.id != null;
      final data = isNewRecord
          ? await _repo.createIssue(state.data)
          : await _repo.updateIssue(state.data);
      emit(state.success(event, data));
      _repo.issueOverviewEvent.add(
        IssueSubmitted(value: data, isNewRecord: isNewRecord),
      );
    } catch (error) {
      emit(state.failure(event));
      rethrow;
    }
  }
}
