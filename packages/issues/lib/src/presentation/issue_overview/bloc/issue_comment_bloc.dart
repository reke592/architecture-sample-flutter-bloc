import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ddd_commons/ddd_commons.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/quote_reply.dart';

part 'issue_comment_event.dart';
part 'issue_comment_state.dart';

class IssueCommentBloc extends Bloc<IssueCommentEvent, IssueCommentState> {
  final IssuesRepository _repo;

  IssueCommentBloc({
    required IssuesRepository repo,
    required int? issueId,
  })  : _repo = repo,
        super(IssueCommentInitial(data: IssueComment(issueId: issueId))) {
    on<SetCommentMessage>(_onChangeMessage);
    on<QuoteMessage>(_onQuoteMessage);
    on<RemoveQuotedMessage>(_onRemoveQuotedMessage);
    on<ResetCommentForm>(_onResetCommentForm);
    on<SubmitComment>(_onSubmitComment, transformer: restartable());
  }

  FutureOr<void> _onChangeMessage(
    SetCommentMessage event,
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

  FutureOr<void> _onSubmitComment(
    SubmitComment event,
    Emitter<IssueCommentState> emit,
  ) async {
    try {
      emit(state.loading(event));
      final isNewRecord = state.data.id == null;
      final data = isNewRecord
          ? await _repo.createComment(state.data)
          : await _repo.updateComment(state.data);
      emit(state.success(event, data));
      _repo.domainEvent.add(CommentSubmitted(
        value: data,
        isNewRecord: isNewRecord,
      ));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }

  FutureOr<void> _onQuoteMessage(
    QuoteMessage event,
    Emitter<IssueCommentState> emit,
  ) {
    emit(state.success(
      event,
      state.data.copyWith(
        quoted: () => QuoteReply(
          commentId: event.source.id!,
          quoteMessage: event.value,
        ),
      ),
    ));
  }

  FutureOr<void> _onRemoveQuotedMessage(
    RemoveQuotedMessage event,
    Emitter<IssueCommentState> emit,
  ) {
    emit(state.success(event, state.data.copyWith(quoted: () => null)));
  }

  FutureOr<void> _onResetCommentForm(
    ResetCommentForm event,
    Emitter<IssueCommentState> emit,
  ) {
    emit(state.success(event, IssueComment(issueId: state.data.issueId)));
  }
}
