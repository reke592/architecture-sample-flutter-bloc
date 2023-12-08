part of 'listeners.dart';

/// on [LoadOverview] trigger [CommentListBloc] to [LoadComments].
///
/// here we trigger to load the comments when the overview has been successfully loaded.
final onLoadOverview = BlocListener<IssueOverviewBloc, IssueOverviewState>(
  listenWhen: (_, current) => current.action is LoadOverview,
  listener: (context, state) {
    if (state.isSuccess && state.data.id != null) {
      context.read<CommentListBloc>().add(LoadComments(state.data.id!));
    }
  },
);
