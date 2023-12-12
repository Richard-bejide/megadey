import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';

class ChatViewModel extends ReactiveViewModel {

  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  List<Map<String, Object>> messages = [
    {
      "id": 1,
      "message": "Hello, I need it",
      "isSender": true,
    },
    {
      "id": 2,
      "message": "Yes Sure...",
      "isSender": false,
    },
    {
      "id": 3,
      "message": "How can i get it?",
      "isSender": true,
    },
    {
      "id": 4,
      "message": "Do you want it delivered",
      "isSender": false,
    },
  ];

  bool showEmojiPicker = false;
  double chatBoxHeight = 0.0;
  String? messageHintText = 'Type Here...';
  TextEditingController messageController = TextEditingController();


  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
