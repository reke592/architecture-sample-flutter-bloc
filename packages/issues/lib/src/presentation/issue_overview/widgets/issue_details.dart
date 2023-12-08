part of 'widgets.dart';

class IssueDetails extends StatelessWidget {
  const IssueDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueOverviewBloc, IssueOverviewState>(
      buildWhen: (_, current) => current.action is LoadOverview,
      builder: (context, state) {
        if (state.isLoading) return const LinearProgressIndicator();

        if (state.isSuccess && state.data.id == null) {
          return IssueForm(
            title: state.data.title,
            description: state.data.description,
          );
        }

        return Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.data.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      state.data.createdAt?.toIso8601String() ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Divider(),
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(state.data.description),
                  ],
                ),
              ),
            ),
            if (state.data.id != null) const IssueCommentListView(),
          ],
        );
      },
    );
  }
}
