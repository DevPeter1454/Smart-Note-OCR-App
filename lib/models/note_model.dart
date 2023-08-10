import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  final String plainText;
  final dynamic content;
  NoteModel({
    required this.plainText,
    required this.content,
  });
  // final DateTime timeStamp;

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'plainText': plainText,
      'content': content,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      plainText: map['plainText'] as String,
      content: map['content'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
