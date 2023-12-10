import 'package:issues/issues.dart';
import 'package:issues/src/domain/models/author.dart';
import 'package:issues/src/domain/models/issue_comment.dart';
import 'package:issues/src/domain/models/issue_report.dart';
import 'package:issues/src/domain/models/quote_reply.dart';

class IssueMemoryRepository extends IssuesRepository {
  final Duration responseDelay;
  final List<IssueReport> _issues = [
    IssueReport(
      id: 1,
      title: 'GPS location not working when offline',
      description:
          'Unable to retrieve GPS location data, encountered in Huawei mobile device without Google Play Service.'
          '\nExpected: to retrieve GPS location from satelites when there is no mobile network available.'
          '\nActual: stuck on loading',
      isClosed: false,
      createdAt: DateTime.tryParse('2023-12-06 21:48:00'),
    )
  ];
  final List<IssueComment> _comments = [
    IssueComment(
      id: 1,
      issueId: 1,
      message:
          'Hi! Thanks for reporting this issue. We\'ll get back to you once we receive a response from the developer.',
      author: Author(name: 'Support'),
      createdAt: DateTime.tryParse('2023-12-06 21:55:00'),
    ),
    IssueComment(
      id: 2,
      issueId: 1,
      message:
          'This issue may be related to the physical components of the device itself. '
          'GPS can function without internet connectivity using satellite data. '
          'However, some modern devices leverage A-GPS, which is faster than traditional GPS but requires assistance data to operate in areas with limited or no internet connectivity. '
          'The assistance data is stored locally on the device for a specific period. '
          'During this time, the device can acquire GPS fixes more quickly. '
          'Unfortunately, there is no way to control how long the data is stored locally, and there is no option to disable A-GPS without custom modifications or rooting, which is not a viable suggestion for end-users.',
      author: Author(name: 'Support'),
      createdAt: DateTime.tryParse('2023-12-06 22:08:00'),
    ),
    IssueComment(
      id: 3,
      issueId: 1,
      message:
          'regarding this part of your comment, would it be possible to request a list of affected manufacturers?',
      quoted: QuoteReply(
        commentId: 2,
        quoteMessage:
            'GPS can function without internet connectivity using satellite data. '
            'However, some modern devices leverage A-GPS, which is faster than traditional GPS but requires assistance data to operate',
      ),
      author: Author(name: 'User'),
      createdAt: DateTime.tryParse('2023-12-06 22:08:00'),
    ),
  ];

  IssueMemoryRepository({
    required super.bus,
    this.responseDelay = const Duration(seconds: 1),
  });

  @override
  Future<IssueComment> createComment(IssueComment value) async {
    if (value.message.trim().isEmpty) {
      throw Exception('Comment meessage is required.');
    }
    final record = value.copyWith(
      id: _comments.length + 1,
      author: Author(name: 'User'),
      createdAt: DateTime.now(),
    );
    _comments.add(record);
    await Future.delayed(responseDelay);
    return record;
  }

  @override
  Future<IssueReport> createIssue(IssueReport value) async {
    if (value.title.trim().isEmpty) {
      throw Exception('Title is required.');
    }
    if (value.description.trim().isEmpty) {
      throw Exception('Description is required.');
    }
    final record = value.copyWith(
      id: _issues.length + 1,
      createdAt: DateTime.now(),
    );
    _issues.add(record);
    await Future.delayed(responseDelay);
    return record;
  }

  @override
  Future<List<IssueComment>> getComments(int issueReportId) async {
    await Future.delayed(responseDelay);
    return List.from(
        _comments.where((element) => element.issueId == issueReportId));
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
