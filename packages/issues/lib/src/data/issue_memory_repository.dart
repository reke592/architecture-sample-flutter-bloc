import 'package:issues/issues.dart';
import 'package:issues/src/domain/models/author.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/issue_report.dart';

class IssueMemoryRepository extends IssueRepository {
  final Duration responseDelay;
  final List<IssueReport> _issues = [
    IssueReport(
      id: 1,
      title: 'Sample Report',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum'
          '\n\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?',
      isClosed: false,
      createdAt: DateTime.tryParse('2023-12-06 21:48:00'),
    )
  ];
  final List<IssueComment> _comments = [
    IssueComment(
      id: 1,
      issueId: 1,
      message: 'Sample comment',
      author: Author(name: 'Erric'),
      createdAt: DateTime.now(),
    ),
  ];

  IssueMemoryRepository({this.responseDelay = const Duration(seconds: 1)});

  @override
  Future<IssueComment> createComment(IssueComment value) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<IssueReport> createIssue(IssueReport value) async {
    final copy = value.copyWith(id: _issues.length + 1);
    _issues.add(copy);
    await Future.delayed(responseDelay);
    return copy;
  }

  @override
  Future<List<IssueComment>> getComments(IssueReport value) async {
    await Future.delayed(responseDelay);
    return List.from(_comments.where((element) => element.issueId == value.id));
  }

  @override
  Future<List<IssueReport>> getIssues() async {
    await Future.delayed(responseDelay);
    return List<IssueReport>.from(_issues);
  }

  @override
  Future<IssueComment> updateComment(IssueComment value) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }

  @override
  Future<IssueReport> updateIssue(IssueReport value) {
    // TODO: implement updateIssue
    throw UnimplementedError();
  }

  @override
  Future<IssueReport> loadOverview(int id) async {
    await Future.delayed(responseDelay);
    final index = _issues.indexWhere((element) => element.id == id);
    if (index < 0) throw Exception('Not found');
    return _issues[index].copyWith();
  }
}
