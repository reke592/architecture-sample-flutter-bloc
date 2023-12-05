import 'package:issues/src/domain/models/author.dart';
import 'package:issues/src/domain/models/issue_comment.dart';

class IssueReport {
  final int? id;
  final Author? author;
  final String title;
  final String description;
  final List<IssueComment> comments;
  final bool isClosed;

  const IssueReport({
    this.id,
    this.author,
    this.title = '',
    this.description = '',
    this.comments = const [],
    this.isClosed = false,
  });

  IssueReport copyWith({
    int? id,
    Author? author,
    String? title,
    String? description,
    List<IssueComment>? comments,
    bool? isClosed,
  }) =>
      IssueReport(
        id: id ?? this.id,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        comments: comments ?? this.comments,
        isClosed: isClosed ?? this.isClosed,
      );
}
