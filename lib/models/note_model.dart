import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  final String plainText;
  final dynamic content;
  final String? id;
  final String category;

  NoteModel({
    required this.plainText,
    required this.content,
    this.id,
    required this.category,
  });
  // final DateTime timeStamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'plainText': plainText,
      'content': content,
      'id': id,
      'category': category,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      plainText: map['plainText'] as String,
      content: map['content'] as dynamic,
      id: map['id'] != null ? map['id'] as String : null,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
