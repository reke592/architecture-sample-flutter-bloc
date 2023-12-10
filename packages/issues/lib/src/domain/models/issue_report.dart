import 'package:issues/src/domain/models/author.dart';

class IssueReport {
  final int? id;
  final Author? author;
  final String title;
  final String description;
  final bool isClosed;
  final DateTime? createdAt;
  final DateTime? modifiedAt;

  const IssueReport({
    this.id,
    this.author,
    this.title = '',
    this.description = '',
    this.isClosed = false,
    this.createdAt,
    this.modifiedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'is_closed': isClosed,
      };

  IssueReport copyWith({
    int? id,
    Author? author,
    String? title,
    String? description,
    bool? isClosed,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) =>
      IssueReport(
        id: id ?? this.id,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        isClosed: isClosed ?? this.isClosed,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
}
