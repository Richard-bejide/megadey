import 'package:flutter/material.dart';
import 'package:megadey_mobile/core/services/utility_storage_service.dart';
import 'package:megadey_mobile/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import '../../app/locator.dart';
import '../../core/services/video_player_service.dart';
import '../../core/utilities/widgets/request_authentication_widget.dart';
import '../favourites/favourites_view.dart';
import '../home/home_view.dart';
import '../messages/messages_view.dart';
import '../sell/sell_view.dart';

class DashboardViewModel extends ReactiveViewModel {
  int selectedIndex = 0;
  final List<Widget> pages = [
    HomeView(),
    FavouritesView(),
    SellView(),
    MessagesView(),
    ProfileView(),
  ];

  DateTime? currentBackPressTime;

  void setup(BuildContext context) async {
    locator<VideoPlayerService>().videoPlayerController?.dispose(); //stop video
  }

  void onTap(int value, BuildContext context) async {
   if(StorageService().getBool('isLoggedIn') == true || value == 0){
    selectedIndex = value;
    notifyListeners();
   }else{
     RequestAuthenticationModal(context);
   }
  }

  //cancels app if back button is pressed on home page
  Future<bool> onWillPop() {
    if (selectedIndex == 0) {
      return Future.value(true);
    } else {
      selectedIndex = 0; //navigate back to home view
      notifyListeners();
    }
    return Future.value(false);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
