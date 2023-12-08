import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_report.dart';

part 'issue_overview_event.dart';
part 'issue_overview_state.dart';

class IssueOverviewBloc extends Bloc<IssueOverviewEvent, IssueOverviewState> {
  final IssuesRepository _repo;

  IssueOverviewBloc({
    required IssuesRepository repo,
    IssueReport? data,
  })  : _repo = repo,
        super(IssueOverviewInitial(data: data ?? const IssueReport())) {
    on<SubmitIssue>(_onSubmitIssue, transformer: restartable());
    on<LoadOverview>(_onLoadOverview);
  }

  FutureOr<void> _onLoadOverview(
    LoadOverview event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final data =
          event.id == null ? state.data : await _repo.loadOverview(event.id!);
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }

  FutureOr<void> _onSubmitIssue(
    SubmitIssue event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final request = state.data.copyWith(
        title: event.title,
        description: event.description,
      );
      final isNewRecord = state.data.id == null;
      final data = isNewRecord
          ? await _repo.createIssue(request)
          : await _repo.updateIssue(request);
      emit(state.success(event, data));
      _repo.domainEvent.add(
        IssueReportSubmitted(value: data, isNewRecord: isNewRecord),
      );
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }
}
