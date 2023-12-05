import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_comment.dart';

part 'issue_comment_event.dart';
part 'issue_comment_state.dart';

class IssueCommentBloc extends Bloc<IssueCommentEvent, IssueCommentState> {
  final IssueRepository _repo;

  IssueCommentBloc({
    required IssueRepository repo,
  })  : _repo = repo,
        super(const IssueCommentState()) {
    on<ChangeMessage>(_onChangeMessage);
    on<SubmitComment>(_onSaveComment, transformer: restartable());
  }

  FutureOr<void> _onChangeMessage(
    ChangeMessage event,
    Emitter<IssueCommentState> emit,
  ) {
    emit(
      state.copyWith(
        action: event,
        mutation: BlocMutation.success,
        data: state.data.copyWith(message: event.value),
      ),
    );
  }

  FutureOr<void> _onSaveComment(
    SubmitComment event,
    Emitter<IssueCommentState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final isNewRecord = state.data.id != null;
      final data = isNewRecord
          ? await _repo.updateComment(state.data)
          : await _repo.createComment(state.data);
      emit(state.success(event, data));
      _repo.issueCommentEvent.add(CommentSubmitted(
        value: data,
        isNewRecord: isNewRecord,
      ));
    } catch (error) {
      emit(state.failure(event));
      rethrow;
    }
  }
}
