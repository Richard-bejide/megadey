import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class ChatService with ReactiveServiceMixin {
  RxValue<bool> _isLoading = RxValue<bool>(false);
  RxValue<String?> _username = RxValue<String?>(null);
  RxValue<String?> _profilePhoto = RxValue<String?>(null);
  RxValue<String?> _conversationID = RxValue<String?>(null);
  RxValue<List<Map<String, dynamic>>> _chats = RxValue<List<Map<String, dynamic>>>([]);
  RxValue<ScrollController?> _scrollController = RxValue<ScrollController?>(null);

  ChatService() {
    listenToReactiveValues(
        [
          _username,
          _profilePhoto,
          _conversationID,
          _chats,
          _scrollController,
          _isLoading
        ]);
  }

  bool get isLoading => _isLoading.value;

  String? get username => _username.value;

  String? get profilePhoto => _profilePhoto.value;

  String? get conversationID => _conversationID.value;

  List<Map<String, dynamic>> get chats => _chats.value;

  ScrollController? get scrollController => _scrollController.value;

  set setUsername(String username) => _username.value = username;

  set setUserProfilePhoto(String photo) => _profilePhoto.value = photo;

  set setConversationID(String? id) => _conversationID.value = id;

  set setChats(List<Map<String, dynamic>> chats) => _chats.value = chats;

  set setScrollController(ScrollController? scrollController) =>
      _scrollController.value = scrollController;

  void clearChatData() {
    _chats.value.clear();
    _conversationID.value = null;
    _profilePhoto.value = null;
    _username.value = null;
  }

  DatabaseReference? _dbRef;
  dynamic ref1;

  Future<void> listenForMessageEvent() async {
    try {
      _isLoading.value = true;
      notifyListeners();

      _scrollController.value = ScrollController();
      print('conversation id is ${_conversationID.value}');
      _dbRef = FirebaseDatabase.instance.ref("chats/messages/${_conversationID.value}"); //not existing if user has no previous messages

      final snapshot = await _dbRef?.get();
      if (snapshot!.exists) {
        ref1 = _dbRef?.onChildAdded.listen((event) {
          // A new message has been added, so add it to the displayed list.
          _chats.value.add(Map<String, dynamic>.from({'${event.snapshot.key}': event.snapshot.value}));
          _isLoading.value = false;
          notifyListeners();
          Future.delayed(const Duration(seconds: 1), () async {
            scrollToLatestMessage();
          });
        });
      } else {
        _isLoading.value = false;
        notifyListeners();
      }
    } catch (e) {
      _isLoading.value = false;
      notifyListeners();
      rethrow;
    }
  }


  void scrollToLatestMessage() {
    _scrollController.value!.animateTo(_scrollController.value!.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn,
    );
  }

  void disposeMessageListener() {
    if (ref1 != null) {
      ref1.cancel();
    }
  }
}
