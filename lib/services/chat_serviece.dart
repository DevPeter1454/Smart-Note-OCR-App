import 'package:smartnote/models/chat_model.dart';

class ChatService {
  List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => _chatList;

  void setChatList(List<ChatModel> chatsList) {
    _chatList = chatList;
  }
}
