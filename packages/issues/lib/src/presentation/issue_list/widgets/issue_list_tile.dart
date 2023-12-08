part of 'widgets.dart';

class IssueListTile extends StatelessWidget {
  final IssueReport data;

  const IssueListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    return ListTile(
      title: Text(data.title),
      subtitle: !isLandScape ? Text(data.createdAt!.toIso8601String()) : null,
      trailing: isLandScape ? Text(data.createdAt!.toIso8601String()) : null,
      onTap: () {
        context.pushNamed('view Issue', pathParameters: {
          'id': data.id.toString(),
        });
      },
    );
  }
}
