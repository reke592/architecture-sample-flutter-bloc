part of 'widgets.dart';

class IssueCommentForm extends StatefulWidget {
  const IssueCommentForm({super.key});

  @override
  State<IssueCommentForm> createState() => _IssueCommentFormState();
}

class _IssueCommentFormState extends State<IssueCommentForm> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IssueCommentBloc, IssueCommentState>(
      listenWhen: (_, current) => current.action is ResetCommentForm,
      listener: (_, state) {
        setState(() {
          controller.text = '';
        });
      },
      buildWhen: (_, current) =>
          current.action is SubmitComment ||
          current.action is ResetCommentForm ||
          current.action is QuoteMessage ||
          current.action is RemoveQuotedMessage,
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.data.quoted != null)
                  Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(state.data.quoted!.quoteMessage),
                        ),
                      ),
                    ],
                  ),
                TextField(
                  minLines: 3,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: 'Add Comment...'),
                  controller: controller,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.data.quoted != null)
                      TextButton(
                        onPressed: () {
                          context
                              .read<IssueCommentBloc>()
                              .add(RemoveQuotedMessage());
                        },
                        child: const Text('Remove quoted message'),
                      ),
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              context.read<IssueCommentBloc>()
                                ..add(SetCommentMessage(controller.text))
                                ..add(SubmitComment());
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit comment'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
