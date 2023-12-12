import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/services/video_player_service.dart';
import '../dashboard/dashboard_view.dart';
import 'package:video_player/video_player.dart';

class StartupViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool get isLoggedIn =>  _storageService.getBool('isLoggedIn') ?? false;
  bool get skipOnBoarding => _storageService.getBool('skipOnBoarding') ?? false;

  int currentPage = 1;

  final VideoPlayerService _videoPlayerService = locator<VideoPlayerService>();

  VideoPlayerController? videoPlayerController;

  void setup(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3), () async {
        _initVideoPlayer();
        videoPlayerController = _videoPlayerService.videoPlayerController;
        currentPage = 2;
        notifyListeners();
        Future.delayed(const Duration(seconds: 5), () async {
          navigateToView();
        });
    });

  }

  Future<void> _initVideoPlayer() async {
    _videoPlayerService.setVideoPlayerController = VideoPlayerController.asset('assets/videos/bg_video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        notifyListeners();
      });
    _videoPlayerService.videoPlayerController!.play();
    _videoPlayerService.videoPlayerController!.setLooping(true);
  }

  void navigateToView() {
    Future.delayed(const Duration(milliseconds: 210), () async {
      if (!skipOnBoarding && !isLoggedIn) {
        Future.delayed(const Duration(milliseconds: 210),
                () => _navigationService.replaceWith(DashboardView.routeName));
      }else if (skipOnBoarding  && isLoggedIn) {
        Future.delayed(const Duration(milliseconds: 210),
                () => _navigationService.replaceWith(DashboardView.routeName));
      } else {
        Future.delayed(const Duration(milliseconds: 210),
                () => _navigationService.replaceWith(DashboardView.routeName));
      }
    });
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
