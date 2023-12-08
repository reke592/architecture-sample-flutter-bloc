import 'dart:async';

import 'package:ddd_commons/ddd_commons.dart';
import 'package:flutter/foundation.dart';
import 'package:issues/src/domain/issues_repository.dart';
import 'package:issues/src/domain/models/issue_comment.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final IssuesRepository _repo;
  late final StreamSubscription<IssuesDomainEvent> _domainEventListener;

  CommentListBloc({
    required IssuesRepository repo,
    required int? issueId,
  })  : _repo = repo,
        super(const CommentListStateInitial()) {
    on<LoadComments>(_onLoadComments);
    on<AppendNewComment>(_onAppendNewComment);
    on<ReplaceExistingComment>(_onReplaceExistingComment);
    _domainEventListener = repo.getDomainEvent().listen((event) {
      // here we trigger to load the comments when the overview has been successfully loaded.
      if (event is IssueReportLoaded) {
        // we can also add validations
        // eg. this feature can view multiple reports at the same time.
        if (event.value.id == issueId) {
          add(LoadComments(event.value.id));
        }
      } else if (event is CommentSubmitted) {
        if (event.value.issueId == issueId) {
          if (event.isNewRecord) {
            add(AppendNewComment(event.value));
          } else {
            add(ReplaceExistingComment(event.value));
          }
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await _domainEventListener.cancel();
    return super.close();
  }

  FutureOr<void> _onLoadComments(
    LoadComments event,
    Emitter<CommentListState> emit,
  ) async {
    try {
      if (event.issueReportId == null) return;
      emit(state.loading(event));
      final data = await _repo.getComments(event.issueReportId!);
      emit(state.success(event, data));
    } catch (error) {
      emit(state.failure(event, error));
      rethrow;
    }
  }

  FutureOr<void> _onAppendNewComment(
    AppendNewComment event,
    Emitter<CommentListState> emit,
  ) {
    emit(
      state.success(
        event,
        List<IssueComment>.from(state.data)..add(event.value),
      ),
    );
  }

  FutureOr<void> _onReplaceExistingComment(
    ReplaceExistingComment event,
    Emitter<CommentListState> emit,
  ) {
    final index =
        state.data.indexWhere((element) => element.id == event.value.id);
    if (index > -1) {
      final updated = List<IssueComment>.from(state.data);
      updated[index] = event.value;
      emit(state.success(event, updated));
    }
  }
}
