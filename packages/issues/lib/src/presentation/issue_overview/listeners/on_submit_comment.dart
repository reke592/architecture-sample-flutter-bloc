import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:issues/src/presentation/issue_overview/bloc/issue_comment_bloc.dart';

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
