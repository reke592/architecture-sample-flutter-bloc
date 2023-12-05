import 'package:issues/src/domain/models/author.dart';
import 'package:issues/src/domain/models/quote_reply.dart';

class IssueComment {
  final int? id;
  final Author? author;
  final String message;
  final List<QuoteReply> quotes;

  const IssueComment({
    this.id,
    this.message = '',
    this.author,
    this.quotes = const [],
  });

  IssueComment copyWith({
    int? id,
    Author? author,
    String? message,
    List<QuoteReply>? quotes,
  }) =>
      IssueComment(
        id: id ?? this.id,
        author: author ?? this.author,
        message: message ?? this.message,
        quotes: quotes ?? this.quotes,
      );
}
