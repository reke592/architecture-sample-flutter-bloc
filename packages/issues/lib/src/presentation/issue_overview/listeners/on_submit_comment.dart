part of 'listeners.dart';

/// reset comment form upon successful submit, or display a message dialog regarding the error
final onSubmitComment = BlocListener<IssueCommentBloc, IssueCommentState>(
  listenWhen: (_, current) => current.action is SubmitComment,
  listener: (context, state) {
    if (state.isSuccess) {
      context.read<IssueCommentBloc>().add(ResetCommentForm());
    } else if (state.isFailure) {
      MessageDialog.showError(context, state.error!);
    }
  },
);
