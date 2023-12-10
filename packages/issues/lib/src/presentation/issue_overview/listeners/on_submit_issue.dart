part of 'listeners.dart';

/// on SubmitIssue close the form and view the newly created report
final onSubmitIssue = BlocListener<IssueOverviewBloc, IssueOverviewState>(
  listener: (context, state) {
    if (state.isSuccess) {
      if (state.action is SubmitIssue) {
        Navigator.maybePop(context);
        Future.microtask(
          () => context.pushNamed(
            'view Issue',
            pathParameters: {
              'id': state.data.id.toString(),
            },
            extra: state.data,
          ),
        );
      }
    }
  },
);
