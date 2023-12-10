import 'package:issues/src/domain/models/author.dart';
import 'package:issues/src/domain/models/quote_reply.dart';

class IssueComment {
  final int? id;
  final int? issueId;
  final Author? author;
  final String message;
  final QuoteReply? quoted;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  const IssueComment({
    this.id,
    this.issueId,
    this.message = '',
    this.author,
    this.quoted,
    this.createdAt,
    this.modifiedAt,
  });

  IssueComment copyWith({
    int? id,
    int? issueId,
    Author? author,
    String? message,
    QuoteReply? Function()? quoted,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) =>
      IssueComment(
        id: id ?? this.id,
        issueId: issueId ?? this.issueId,
        author: author ?? this.author,
        message: message ?? this.message,
        quoted: quoted != null ? quoted() : this.quoted,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
}
