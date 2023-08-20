import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/app/app.locator.dart';
import 'package:smartnote/app/app.logger.dart';
import 'package:smartnote/models/chat_model.dart';
import 'package:smartnote/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/user_service.dart';

class ChatsViewModel extends StreamViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();
  // final _chatService = ChatService();
  final TextEditingController promptController = TextEditingController();
  final log = getLogger('ChatsViewModel');
  List<ChatModel> chats = [];
  String? _profileInitial;

  String? get profileInitial => _profileInitial;

  String? _photoUrl;
  String? get photoUrl => _photoUrl;


  Future<void> addChat() async {
    setBusy(true);
    if (promptController.text.isNotEmpty) {
      try {
        await _firestoreService.sendPrompt(message: promptController.text).then((value) { log.i('value');});
        promptController.clear();
        _snackbarService.showSnackbar(message: 'Message sent', duration: const Duration(seconds: 1));

      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString(), duration: const Duration(seconds: 1));
      }
    } else {
      _snackbarService.showSnackbar(message: 'Please enter a prompt', duration: const Duration(seconds: 1));
    }
  }

  @override
  Stream<QuerySnapshot> get stream => _firestoreService.getChats();

  @override
  void onData(data) {
    super.onData(data);
    log.i('start');
    //_chatService.setChatList(convertDocsToChat(data.docs));
    log.i('End');
    setBusy(false);

    if (data == null) {
      _snackbarService.showSnackbar(message: 'No Chat yet');
    }
    
    notifyListeners();
    
  }

  @override
  void onError(error) {
    super.onError(error);
    _snackbarService.showSnackbar(message: error.toString());
  }

  @override
  void onSubscribed() {
    super.onSubscribed();
    log.i('onSubscribed');
  }

  void init() {
    _profileInitial = _userService.userData!.displayName.split(' ').first; 
    _photoUrl = _userService.userData!.photoURL;
    notifyListeners();
  }
}
