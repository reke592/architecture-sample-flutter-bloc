part of 'widgets.dart';

class IssueCommentTile extends StatelessWidget {
  final IssueComment data;

  const IssueCommentTile({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.author!.name,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            AppTheme.gap1,
            if (data.quoted != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.quoted!.quoteMessage,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            SelectableText(
              data.message,
              onSelectionChanged: (selection, cause) {
                context.read<TextSelectionBloc>().add(TextSelectionUpdate(
                    selection.textInside(data.message), data));
              },
            ),
            AppTheme.gap2,
            Text(
              data.createdAt!.toIso8601String(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            BlocBuilder<TextSelectionBloc, TextSelectionState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.isNotEmpty && state.source == data)
                      OutlinedButton(
                        onPressed: () {
                          context.read<TextSelectionBloc>()
                            ..add(AcceptSelectionData())
                            ..add(ClearSelectionData());
                        },
                        child: const Text('Quote message'),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
