import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class MessagesViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;

  List<Map<String, Object>>? messages = [
    {
      "id": 1,
      "image": "assets/images/messages1.png",
      "title": "sarah Ayo",
      "subtitle": "Hello, is this product still available?",
      "time":'02:23pm',
      "unread":2
    },
    {
      "id": 2,
      "image": "assets/images/messages2.png",
      "title": "James Ward",
      "subtitle": "Hello, is this product still available?",
      "time":'02:03pm',
      "unread":6
    },
    {
      "id": 3,
      "image": "assets/images/messages3.png",
      "title": "Annon Ano",
      "subtitle": "Hello, is this product still available?",
      "time":'01:23pm',
      "unread":2
    },
    {
      "id": 4,
      "image": "assets/images/messages4.png",
      "title": "Jess Akinto",
      "subtitle": "Hello!!",
      "time":'05:13am',
      "unread":2
    },
    {
      "id": 5,
      "image": "assets/images/messages1.png",
      "title": "Ebuka Dennis",
      "subtitle": "Hello, is this product still available?",
      "time":'03:43am',
      "unread":0
    },
  ];

  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
