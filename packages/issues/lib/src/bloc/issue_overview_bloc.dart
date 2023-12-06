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
        super(IssueOverviewState(report: data ?? const IssueReport())) {
    on<SubmitIssue>(_onSubmitIssue, transformer: restartable());
    on<IssueOverviewSequentialEvent>(
      (event, emit) {
        if (event is LoadOverview) return _onLoadOverview(event, emit);
        if (event is LoadComments) return _onLoadComments(event, emit);
      },
      transformer: sequential(),
    );
  }

  FutureOr<void> _onLoadOverview(
    LoadOverview event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final data =
          event.id == null ? state.report : await _repo.loadOverview(event.id!);
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }

  FutureOr<void> _onLoadComments(
    LoadComments event,
    Emitter<IssueOverviewState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final data = await _repo.getComments(state.report);
      emit(state.withComments(event, data));
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
      final request = state.report.copyWith(
        title: event.title,
        description: event.description,
      );
      final isNewRecord = state.report.id == null;
      final data = isNewRecord
          ? await _repo.createIssue(request)
          : await _repo.updateIssue(request);
      emit(state.success(event, data));
      _repo.issueOverviewEvent.add(
        IssueSubmitted(value: data, isNewRecord: isNewRecord),
      );
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }
}
