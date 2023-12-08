part of 'listeners.dart';

/// on AcceptSelectionData include text selection from other comments in form data
final onAcceptSelectionData =
    BlocListener<TextSelectionBloc, TextSelectionState>(
  listenWhen: (_, current) => current.action is AcceptSelectionData,
  listener: (context, state) {
    if (state.source is IssueComment) {
      context.read<IssueCommentBloc>().add(
            QuoteMessage(
              source: state.source as IssueComment,
              value: state.text,
            ),
          );
    }
  },
);
