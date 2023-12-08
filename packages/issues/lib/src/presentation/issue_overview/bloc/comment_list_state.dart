part of 'comment_list_bloc.dart';

typedef CommentListState = BlocDataState<List<IssueComment>, CommentListEvent>;

@immutable
class CommentListStateInitial extends CommentListState {
  const CommentListStateInitial({super.data = const []});
}
